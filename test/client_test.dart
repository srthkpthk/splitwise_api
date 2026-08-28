import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:splitwise_api/splitwise_api.dart';
import 'package:test/test.dart';

import 'support/fake_api.dart';
import 'support/spec_examples.dart';

const _prefix = '/api/v3.0';

void main() {
  group('users', () {
    test('getCurrentUser', () async {
      final fixture = okResponseExample('/get_current_user', 'get');
      final api = FakeApi(respond: fixture);
      final me = await api.client.getCurrentUser();
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_current_user',
      );
      expect(me.id, (fixture['user'] as Map)['id']);
      expect(me.notifications, isNotEmpty);
    });

    test('getUser', () async {
      final api = FakeApi(respond: okResponseExample('/get_user/{id}', 'get'));
      final user = await api.client.getUser(42);
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_user/42',
      );
      expect(user, isA<User>());
    });

    test('updateUser sends JSON and accepts the unwrapped response', () async {
      final api = FakeApi(respond: exampleOf(componentSchema('user')));
      final user = await api.client.updateUser(
        7,
        const UpdateUserRequest(firstName: 'Ada', locale: 'en'),
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/update_user/7',
        jsonBody: {'first_name': 'Ada', 'locale': 'en'},
      );
      expect(user.firstName, isNotNull);
    });

    test('updateUser also accepts a wrapped response', () async {
      final api = FakeApi(
        respond: {'user': exampleOf(componentSchema('user'))},
      );
      final user = await api.client.updateUser(7, const UpdateUserRequest());
      expect(user, isA<User>());
    });
  });

  group('groups', () {
    test('getGroups', () async {
      final api = FakeApi(respond: okResponseExample('/get_groups', 'get'));
      final groups = await api.client.getGroups();
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_groups',
      );
      expect(groups, hasLength(1));
      expect(groups.single.members, isNotEmpty);
    });

    test('getGroup', () async {
      final api = FakeApi(respond: okResponseExample('/get_group/{id}', 'get'));
      final group = await api.client.getGroup(0);
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_group/0',
      );
      expect(group.simplifiedDebts, isA<List<Debt>>());
    });

    test('createGroup', () async {
      final api = FakeApi(respond: okResponseExample('/create_group', 'post'));
      final group = await api.client.createGroup(
        const CreateGroupRequest(
          name: 'Trip',
          groupType: GroupType.trip,
          simplifyByDefault: true,
          members: [GroupMemberInput.user(9)],
        ),
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/create_group',
        jsonBody: {
          'name': 'Trip',
          'group_type': 'trip',
          'simplify_by_default': true,
          'users__0__user_id': 9,
        },
      );
      expect(group, isA<Group>());
    });

    test('deleteGroup / undeleteGroup are POSTs that return nothing', () async {
      final api = FakeApi(responder: (_) => {'success': true});
      await api.client.deleteGroup(5);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/delete_group/5',
      );
      await api.client.undeleteGroup(5);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/undelete_group/5',
      );
    });

    test('addUserToGroup by id', () async {
      final api = FakeApi(
        respond: okResponseExample('/add_user_to_group', 'post'),
      );
      final user = await api.client.addUserToGroup(groupId: 1, userId: 2);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/add_user_to_group',
        jsonBody: {'group_id': 1, 'user_id': 2},
      );
      expect(user, isA<User>());
    });

    test('addUserToGroupByEmail', () async {
      final api = FakeApi(
        respond: okResponseExample('/add_user_to_group', 'post'),
      );
      await api.client.addUserToGroupByEmail(
        groupId: 1,
        email: 'g@example.com',
        firstName: 'Grace',
        lastName: 'Hopper',
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/add_user_to_group',
        jsonBody: {
          'group_id': 1,
          'first_name': 'Grace',
          'last_name': 'Hopper',
          'email': 'g@example.com',
        },
      );
    });

    test('removeUserFromGroup', () async {
      final api = FakeApi(respond: {'success': true, 'errors': {}});
      await api.client.removeUserFromGroup(groupId: 1, userId: 2);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/remove_user_from_group',
        jsonBody: {'group_id': 1, 'user_id': 2},
      );
    });
  });

  group('friends', () {
    test('getFriends', () async {
      final api = FakeApi(respond: okResponseExample('/get_friends', 'get'));
      final friends = await api.client.getFriends();
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_friends',
      );
      expect(friends.single.groups, isNotEmpty);
    });

    test('getFriend', () async {
      final api = FakeApi(
        respond: okResponseExample('/get_friend/{id}', 'get'),
      );
      await api.client.getFriend(3);
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_friend/3',
      );
    });

    test('createFriend uses the user_* property names', () async {
      final api = FakeApi(respond: okResponseExample('/create_friend', 'post'));
      await api.client.createFriend(
        email: 'ada@example.com',
        firstName: 'Ada',
        lastName: 'Lovelace',
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/create_friend',
        jsonBody: {
          'user_email': 'ada@example.com',
          'user_first_name': 'Ada',
          'user_last_name': 'Lovelace',
        },
      );
    });

    test('createFriends is always form-encoded', () async {
      final api = FakeApi(
        respond: okResponseExample('/create_friends', 'post'),
      );
      final friends = await api.client.createFriends(const [
        NewFriend(
          email: 'alan@example.org',
          firstName: 'Alan',
          lastName: 'Turing',
        ),
        NewFriend(email: 'existing_user@example.com'),
      ]);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/create_friends',
        formBody: {
          'users__0__first_name': 'Alan',
          'users__0__last_name': 'Turing',
          'users__0__email': 'alan@example.org',
          'users__1__email': 'existing_user@example.com',
        },
      );
      expect(friends, isNotEmpty);
    });

    test('deleteFriend', () async {
      final api = FakeApi(respond: {'success': true, 'errors': []});
      await api.client.deleteFriend(8);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/delete_friend/8',
      );
    });
  });

  group('expenses', () {
    test('getExpense', () async {
      final fixture = okResponseExample('/get_expense/{id}', 'get');
      final api = FakeApi(respond: fixture);
      final expense = await api.client.getExpense(51023);
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_expense/51023',
      );
      expect(expense.id, (fixture['expense'] as Map)['id']);
      expect(expense.users, isNotEmpty);
      expect(expense.category, isA<SplitwiseCategory>());
    });

    test('getExpenses encodes every filter as a query parameter', () async {
      final api = FakeApi(respond: okResponseExample('/get_expenses', 'get'));
      await api.client.getExpenses(
        groupId: 1,
        friendId: 2,
        datedAfter: DateTime.utc(2024, 1, 1),
        datedBefore: DateTime.utc(2024, 2, 1),
        updatedAfter: DateTime.utc(2024, 3, 1),
        updatedBefore: DateTime.utc(2024, 4, 1),
        limit: 10,
        offset: 20,
      );
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_expenses',
        query: {
          'group_id': '1',
          'friend_id': '2',
          'dated_after': '2024-01-01T00:00:00.000Z',
          'dated_before': '2024-02-01T00:00:00.000Z',
          'updated_after': '2024-03-01T00:00:00.000Z',
          'updated_before': '2024-04-01T00:00:00.000Z',
          'limit': '10',
          'offset': '20',
        },
      );
    });

    test('getExpenses omits unset filters', () async {
      final api = FakeApi(respond: okResponseExample('/get_expenses', 'get'));
      await api.client.getExpenses();
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_expenses',
        query: {},
      );
    });

    test('createExpense with an equal split sends typed JSON', () async {
      final api = FakeApi(
        respond: okResponseExample('/create_expense', 'post'),
      );
      final expenses = await api.client.createExpense(
        const EqualGroupSplit(
          cost: '25.00',
          description: 'Brunch',
          groupId: 391,
        ),
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/create_expense',
        jsonBody: {
          'cost': '25.00',
          'description': 'Brunch',
          'group_id': 391,
          'split_equally': true,
        },
      );
      expect(expenses, hasLength(1));
    });

    test('createExpense by shares flattens users', () async {
      final api = FakeApi(
        respond: okResponseExample('/create_expense', 'post'),
      );
      await api.client.createExpense(
        SplitByShares(
          cost: '10.00',
          description: 'Taxi',
          users: const [
            ExpenseShareInput.user(
              userId: 1,
              paidShare: '10.00',
              owedShare: '5.00',
            ),
            ExpenseShareInput.user(
              userId: 2,
              paidShare: '0',
              owedShare: '5.00',
            ),
          ],
        ),
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/create_expense',
        jsonBody: {
          'cost': '10.00',
          'description': 'Taxi',
          'group_id': 0,
          'users__0__user_id': 1,
          'users__0__paid_share': '10.00',
          'users__0__owed_share': '5.00',
          'users__1__user_id': 2,
          'users__1__paid_share': '0',
          'users__1__owed_share': '5.00',
        },
      );
    });

    test('updateExpense', () async {
      final api = FakeApi(
        respond: okResponseExample('/update_expense/{id}', 'post'),
      );
      await api.client.updateExpense(
        51023,
        const UpdateExpenseRequest(description: 'Brunch (updated)'),
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/update_expense/51023',
        jsonBody: {'description': 'Brunch (updated)'},
      );
    });

    test('deleteExpense / undeleteExpense', () async {
      final api = FakeApi(respond: {'success': true});
      await api.client.deleteExpense(1);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/delete_expense/1',
      );
      await api.client.undeleteExpense(1);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/undelete_expense/1',
      );
    });
  });

  group('comments', () {
    test('getComments passes expense_id as a query parameter', () async {
      final api = FakeApi(respond: okResponseExample('/get_comments', 'get'));
      final comments = await api.client.getComments(expenseId: 51023);
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_comments',
        query: {'expense_id': '51023'},
      );
      expect(comments.single.user, isA<CommentUser>());
    });

    test('createComment', () async {
      final api = FakeApi(
        respond: okResponseExample('/create_comment', 'post'),
      );
      final comment = await api.client.createComment(
        expenseId: 51023,
        content: 'hi',
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/create_comment',
        jsonBody: {'expense_id': 51023, 'content': 'hi'},
      );
      expect(comment, isA<Comment>());
    });

    test('deleteComment returns the deleted comment', () async {
      final api = FakeApi(
        respond: okResponseExample('/delete_comment/{id}', 'post'),
      );
      final comment = await api.client.deleteComment(79800950);
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/delete_comment/79800950',
      );
      expect(comment, isA<Comment>());
    });
  });

  group('notifications and reference data', () {
    test('getNotifications', () async {
      final api = FakeApi(
        respond: okResponseExample('/get_notifications', 'get'),
      );
      final notifications = await api.client.getNotifications(
        updatedAfter: DateTime.utc(2024, 5, 1),
        limit: 5,
      );
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_notifications',
        query: {'updated_after': '2024-05-01T00:00:00.000Z', 'limit': '5'},
      );
      expect(notifications.single.source, isA<NotificationSource>());
    });

    test('getCurrencies', () async {
      final api = FakeApi(respond: okResponseExample('/get_currencies', 'get'));
      final currencies = await api.client.getCurrencies();
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_currencies',
      );
      expect(currencies.single.currencyCode, isNotNull);
    });

    test('getCategories', () async {
      final api = FakeApi(respond: okResponseExample('/get_categories', 'get'));
      final categories = await api.client.getCategories();
      expectRequest(
        api.lastRequest,
        method: 'GET',
        path: '$_prefix/get_categories',
      );
      expect(categories.single.subcategories, isNotEmpty);
    });
  });

  group('transport behaviour', () {
    test('a base URL without a trailing slash keeps its path', () async {
      final api = FakeApi(
        respond: okResponseExample('/get_groups', 'get'),
        baseUrl: Uri.parse('https://secure.splitwise.com/api/v3.0'),
      );
      await api.client.getGroups();
      expect(api.lastRequest.url.path, '$_prefix/get_groups');
    });

    test('form encoding stringifies values and drops nulls', () async {
      final api = FakeApi(
        respond: okResponseExample('/create_expense', 'post'),
        bodyEncoding: BodyEncoding.formUrlEncoded,
      );
      await api.client.createExpense(
        const EqualGroupSplit(cost: '1.00', description: 'x', groupId: 2),
      );
      expectRequest(
        api.lastRequest,
        method: 'POST',
        path: '$_prefix/create_expense',
        formBody: {
          'cost': '1.00',
          'description': 'x',
          'group_id': '2',
          'split_equally': 'true',
        },
      );
    });

    test('the access-token constructor sends the same bearer header', () async {
      late http.Request seen;
      final client = SplitwiseClient.accessToken(
        'TOKEN',
        httpClient: MockClient((request) async {
          seen = request;
          return http.Response(
            jsonEncode(okResponseExample('/get_groups', 'get')),
            200,
          );
        }),
      );
      await client.getGroups();
      expect(seen.headers['authorization'], 'Bearer TOKEN');
    });

    test(
      '401 throws SplitwiseUnauthorizedException with the message',
      () async {
        final api = FakeApi(
          respond: {'error': 'Invalid API Request: you are not logged in'},
          status: 401,
        );
        await expectLater(
          api.client.getCurrentUser(),
          throwsA(
            isA<SplitwiseUnauthorizedException>()
                .having((e) => e.statusCode, 'statusCode', 401)
                .having((e) => e.errors.messages, 'messages', [
                  'Invalid API Request: you are not logged in',
                ]),
          ),
        );
      },
    );

    test(
      '200 with success:false throws SplitwiseRequestFailedException',
      () async {
        final api = FakeApi(
          respond: {
            'success': false,
            'errors': {
              'expense': ['Expense has already been deleted'],
            },
          },
        );
        await expectLater(
          api.client.deleteExpense(1),
          throwsA(
            isA<SplitwiseRequestFailedException>().having(
              (e) => e.errors.byField['expense'],
              'expense errors',
              ['Expense has already been deleted'],
            ),
          ),
        );
      },
    );

    test(
      '200 with a non-empty errors object throws even without success',
      () async {
        final api = FakeApi(
          respond: {
            'expenses': [],
            'errors': {
              'base': ['You cannot add an expense with no participants'],
            },
          },
        );
        await expectLater(
          api.client.createExpense(
            const EqualGroupSplit(cost: '1', description: 'x', groupId: 1),
          ),
          throwsA(isA<SplitwiseRequestFailedException>()),
        );
      },
    );

    test('a missing payload member throws SplitwiseException', () async {
      final api = FakeApi(respond: {'unexpected': true});
      await expectLater(
        api.client.getCurrentUser(),
        throwsA(isA<SplitwiseException>()),
      );
    });

    test(
      'a non-JSON 200 body throws SplitwiseException, not FormatException',
      () async {
        final api = FakeApi(rawBody: '<html>oops</html>');
        await expectLater(
          api.client.getGroups(),
          throwsA(isA<SplitwiseException>()),
        );
      },
    );
  });
}
