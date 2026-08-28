@Tags(['live'])
@Timeout(Duration(minutes: 5))
library;

import 'dart:io';

import 'package:splitwise_api/splitwise_api.dart';
import 'package:test/test.dart';

/// Exercises the real Splitwise API with a personal API key.
///
/// Run with:
///
/// ```sh
/// SPLITWISE_API_KEY=... dart test --tags live
/// # optionally, to prove the form-encoded escape hatch:
/// SPLITWISE_API_KEY=... SPLITWISE_LIVE_BODY_ENCODING=form dart test --tags live
/// ```
///
/// Only touches data owned by the key's account: it creates a throwaway
/// group, an expense and a comment inside it, then deletes them. It never
/// calls the endpoints that email or mutate other people's accounts
/// (`create_friend(s)`, `add_user_to_group*`, `remove_user_from_group`,
/// `delete_friend`, `update_user`).
void main() {
  final apiKey = Platform.environment['SPLITWISE_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    test(
      'live Splitwise API',
      () {},
      skip:
          'Set SPLITWISE_API_KEY to run the live suite '
          '(SPLITWISE_API_KEY=... dart test --tags live).',
    );
    return;
  }

  final encoding =
      Platform.environment['SPLITWISE_LIVE_BODY_ENCODING'] == 'form'
      ? BodyEncoding.formUrlEncoded
      : BodyEncoding.json;
  const groupPrefix = 'splitwise_api live test';

  late SplitwiseClient client;
  late CurrentUser me;

  setUpAll(() async {
    client = SplitwiseClient.apiKey(apiKey, bodyEncoding: encoding);
    me = await client.getCurrentUser();
  });

  tearDownAll(() => client.close());

  test('read-only endpoints parse', () async {
    expect(me.id, greaterThan(0));
    expect(
      (await client.getCurrencies()).map((c) => c.currencyCode),
      contains('USD'),
    );
    final categories = await client.getCategories();
    expect(categories, isNotEmpty);
    expect(categories.first.subcategories, isNotEmpty);
    expect((await client.getGroups()).map((g) => g.id), contains(0));
    await client.getFriends();
    await client.getNotifications(limit: 5);
    await client.getExpenses(limit: 1);
  });

  test('write round-trip in a throwaway group ($encoding)', () async {
    // Janitor: remove leftovers from crashed runs.
    for (final group in await client.getGroups()) {
      if ((group.name ?? '').startsWith(groupPrefix)) {
        try {
          await client.deleteGroup(group.id);
        } on SplitwiseException {
          // Best effort.
        }
      }
    }

    final group = await client.createGroup(
      CreateGroupRequest(
        name: '$groupPrefix ${DateTime.now().toUtc().toIso8601String()}',
        groupType: GroupType.other,
        simplifyByDefault: true,
      ),
    );
    addTearDown(() async {
      try {
        await client.deleteGroup(group.id);
      } on SplitwiseException {
        // Already deleted by the test body.
      }
    });
    // A JSON `true` that survives the round trip proves the body encoding.
    expect(group.simplifyByDefault, isTrue);
    expect(group.members.map((m) => m.id), contains(me.id));

    final categoryId =
        (await client.getCategories()).first.subcategories.first.id;
    final created = await client.createExpense(
      EqualGroupSplit(
        cost: '1.00',
        description: 'live test expense',
        groupId: group.id,
        currencyCode: me.defaultCurrency ?? 'USD',
        categoryId: categoryId,
      ),
    );
    final expense = created.single;
    expect(double.parse(expense.cost!), 1.0);
    expect(expense.groupId, group.id);
    expect(expense.users.map((u) => u.userId), contains(me.id));

    expect((await client.getExpense(expense.id)).id, expense.id);
    expect(
      (await client.getExpenses(groupId: group.id)).map((e) => e.id),
      contains(expense.id),
    );

    final comment = await client.createComment(
      expenseId: expense.id,
      content: 'live test comment',
    );
    expect(comment.relationId, expense.id);
    expect(
      (await client.getComments(expenseId: expense.id)).map((c) => c.id),
      contains(comment.id),
    );
    expect((await client.deleteComment(comment.id)).id, comment.id);

    final updated = await client.updateExpense(
      expense.id,
      const UpdateExpenseRequest(description: 'live test expense (updated)'),
    );
    expect(updated.single.description, 'live test expense (updated)');
    expect(updated.single.cost, expense.cost);

    await client.deleteExpense(expense.id);
    expect((await client.getExpense(expense.id)).deletedAt, isNotNull);
    // Deleting twice is the documented "200 but success:false" case.
    await expectLater(
      client.deleteExpense(expense.id),
      throwsA(isA<SplitwiseRequestFailedException>()),
    );
    await client.undeleteExpense(expense.id);
    expect((await client.getExpense(expense.id)).deletedAt, isNull);
    await client.deleteExpense(expense.id);

    await client.deleteGroup(group.id);
    await client.undeleteGroup(group.id);
    expect((await client.getGroup(group.id)).id, group.id);
    await client.deleteGroup(group.id);
  });

  test('negative paths map to the documented exceptions', () async {
    await expectLater(
      client.getExpense(1),
      throwsA(
        isA<SplitwiseHttpException>().having(
          (e) => e.statusCode,
          'statusCode',
          isIn([403, 404]),
        ),
      ),
    );

    final bogus = SplitwiseClient.apiKey('bogus');
    addTearDown(bogus.close);
    await expectLater(
      bogus.getCurrentUser(),
      throwsA(
        isA<SplitwiseUnauthorizedException>().having(
          (e) => e.errors.messages.join(),
          'message',
          contains('not logged in'),
        ),
      ),
    );
  });
}
