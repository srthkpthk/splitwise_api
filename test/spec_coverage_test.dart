import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:splitwise_api/splitwise_api.dart';
import 'package:test/test.dart';

import 'support/spec_examples.dart';

/// One invocation per public client method. `add_user_to_group` is covered
/// by two methods because its request body is a `oneOf`.
final Map<String, Future<void> Function(SplitwiseClient)> invokers = {
  'getCurrentUser': (c) => c.getCurrentUser(),
  'getUser': (c) => c.getUser(1),
  'updateUser': (c) => c.updateUser(1, const UpdateUserRequest()),
  'getGroups': (c) => c.getGroups(),
  'getGroup': (c) => c.getGroup(1),
  'createGroup': (c) => c.createGroup(const CreateGroupRequest(name: 'g')),
  'deleteGroup': (c) => c.deleteGroup(1),
  'undeleteGroup': (c) => c.undeleteGroup(1),
  'addUserToGroup': (c) => c.addUserToGroup(groupId: 1, userId: 2),
  'addUserToGroupByEmail': (c) => c.addUserToGroupByEmail(
    groupId: 1,
    email: 'a@b.c',
    firstName: 'a',
    lastName: 'b',
  ),
  'removeUserFromGroup': (c) => c.removeUserFromGroup(groupId: 1, userId: 2),
  'getFriends': (c) => c.getFriends(),
  'getFriend': (c) => c.getFriend(1),
  'createFriend': (c) => c.createFriend(email: 'a@b.c'),
  'createFriends': (c) => c.createFriends(const [NewFriend(email: 'a@b.c')]),
  'deleteFriend': (c) => c.deleteFriend(1),
  'getExpense': (c) => c.getExpense(1),
  'getExpenses': (c) => c.getExpenses(),
  'createExpense': (c) => c.createExpense(
    const EqualGroupSplit(cost: '1', description: 'd', groupId: 1),
  ),
  'updateExpense': (c) => c.updateExpense(1, const UpdateExpenseRequest()),
  'deleteExpense': (c) => c.deleteExpense(1),
  'undeleteExpense': (c) => c.undeleteExpense(1),
  'getComments': (c) => c.getComments(expenseId: 1),
  'createComment': (c) => c.createComment(expenseId: 1, content: 'c'),
  'deleteComment': (c) => c.deleteComment(1),
  'getNotifications': (c) => c.getNotifications(),
  'getCurrencies': (c) => c.getCurrencies(),
  'getCategories': (c) => c.getCategories(),
};

/// `(method, regex)` pairs built from the spec's path templates.
final List<({String method, String template, RegExp pattern})> operations = [
  for (final op in specOperations())
    (
      method: op.split(' ').first,
      template: op.split(' ').last,
      pattern: RegExp(
        '^${RegExp.escape(op.split(' ').last).replaceAll(RegExp.escape('{id}'), r'\d+')}\$',
      ),
    ),
];

void main() {
  test(
    'every documented operation is called by exactly one path shape',
    () async {
      final hits = <String>{};
      final client = SplitwiseClient.apiKey(
        'k',
        httpClient: MockClient((request) async {
          final path = request.url.path.replaceFirst('/api/v3.0', '');
          final match = operations.firstWhere(
            (op) => op.method == request.method && op.pattern.hasMatch(path),
            orElse: () => throw StateError(
              '${request.method} $path is not a documented operation',
            ),
          );
          hits.add('${match.method} ${match.template}');
          return http.Response(
            jsonEncode(
              okResponseExample(match.template, match.method.toLowerCase()),
            ),
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      for (final invoke in invokers.values) {
        await invoke(client);
      }

      expect(hits, specOperations());
    },
  );

  test('every public client method is in the invoker table', () {
    final source = File('lib/src/splitwise_client.dart').readAsStringSync();
    final methods = RegExp(
      r'^\s+Future<[^>]+(?:<[^>]+>)?>\s+(\w+)\(',
      multiLine: true,
    ).allMatches(source).map((m) => m.group(1)!).toSet();
    expect(methods, isNotEmpty);
    expect(methods, invokers.keys.toSet());
  });

  test('the spec still has 27 operations and no parse_sentence', () {
    expect(specOperations(), hasLength(27));
    expect(specPaths.keys, isNot(contains('/parse_sentence')));
  });
}
