import 'package:splitwise_api/splitwise_api.dart';
import 'package:splitwise_api/src/models/requests/flatten.dart';
import 'package:test/test.dart';

import 'support/spec_examples.dart';

final _userKey = RegExp(r'^users__\d+__(user_id|first_name|last_name|email)$');

void main() {
  group('EqualGroupSplit', () {
    test('emits split_equally: true and only documented keys', () {
      final json = EqualGroupSplit(
        cost: '25.00',
        description: 'Brunch',
        groupId: 391,
        date: DateTime.utc(2012, 5, 2, 13),
        repeatInterval: RepeatInterval.monthly,
        currencyCode: 'USD',
        categoryId: 15,
        details: 'notes',
      ).toJson();

      expect(json['split_equally'], isTrue);
      expect(json['group_id'], 391);
      expect(json['date'], '2012-05-02T13:00:00.000Z');
      expect(json['repeat_interval'], 'monthly');
      expect(
        json.keys.toSet().difference(
          propertyKeys(componentSchema('equal_group_split')),
        ),
        isEmpty,
      );
    });
  });

  group('SplitByShares', () {
    test('flattens shares exactly as the by_shares schema documents', () {
      final json = SplitByShares(
        cost: '25.00',
        description: 'Brunch',
        groupId: 0,
        users: const [
          ExpenseShareInput.user(
            userId: 54123,
            paidShare: '25',
            owedShare: '13.55',
          ),
          ExpenseShareInput.newUser(
            email: 'neuyewxyz@example.com',
            firstName: 'Neu',
            lastName: 'Yewzer',
            paidShare: '0',
            owedShare: '11.45',
          ),
        ],
      ).toJson();

      final documented = propertyKeys(componentSchema('by_shares'));
      expect(json.keys.toSet().difference(documented), isEmpty);
      expect(json, containsPair('users__0__user_id', 54123));
      expect(json, containsPair('users__0__paid_share', '25'));
      expect(json, containsPair('users__0__owed_share', '13.55'));
      expect(json, containsPair('users__1__first_name', 'Neu'));
      expect(json, containsPair('users__1__last_name', 'Yewzer'));
      expect(json, containsPair('users__1__email', 'neuyewxyz@example.com'));
      expect(json, containsPair('users__1__paid_share', '0'));
      expect(json, containsPair('users__1__owed_share', '11.45'));
      expect(json, containsPair('group_id', 0));
      expect(json.containsKey('split_equally'), isFalse);
    });

    test('rejects an empty share list', () {
      expect(
        () => SplitByShares(cost: '1.00', description: 'x', users: const []),
        throwsArgumentError,
      );
    });
  });

  group('UpdateExpenseRequest', () {
    test('sends nothing when nothing is set', () {
      expect(const UpdateExpenseRequest().toJson(), isEmpty);
    });

    test('sends only the changed fields', () {
      final json = const UpdateExpenseRequest(
        description: 'renamed',
        groupId: 7,
      ).toJson();
      expect(json, {'description': 'renamed', 'group_id': 7});
    });

    test('replaces shares when users is given', () {
      final json = const UpdateExpenseRequest(
        users: [
          ExpenseShareInput.user(
            userId: 1,
            paidShare: '2.00',
            owedShare: '1.00',
          ),
        ],
      ).toJson();
      expect(json.keys, everyElement(startsWith('users__0__')));
      expect(json['users__0__user_id'], 1);
    });
  });

  group('CreateGroupRequest', () {
    test('flattens members and keeps documented keys', () {
      final json = const CreateGroupRequest(
        name: 'Trip',
        groupType: GroupType.trip,
        simplifyByDefault: true,
        members: [
          GroupMemberInput.user(5823),
          GroupMemberInput.newUser(
            email: 'grace@example.com',
            firstName: 'Grace',
            lastName: 'Hopper',
          ),
        ],
      ).toJson();

      final documented = propertyKeys(requestSchema('/create_group'));
      final plain = json.keys.where((k) => !k.startsWith('users__')).toSet();
      expect(plain.difference(documented), isEmpty);
      expect(json['group_type'], 'trip');
      expect(json['simplify_by_default'], isTrue);
      expect(json['users__0__user_id'], 5823);
      expect(json['users__1__email'], 'grace@example.com');
      expect(json['users__1__first_name'], 'Grace');
      for (final key in json.keys.where((k) => k.startsWith('users__'))) {
        expect(key, matches(_userKey));
      }
    });

    test('omits optional fields that are not set', () {
      expect(const CreateGroupRequest(name: 'x').toJson(), {'name': 'x'});
    });
  });

  group('NewFriend / create_friends', () {
    test('flattens to the keys in the spec example', () {
      final json = flattenUsers(
        const [
          NewFriend(
            email: 'alan@example.org',
            firstName: 'Alan',
            lastName: 'Turing',
          ),
          NewFriend(email: 'existing_user@example.com'),
        ].map((f) => f.toJson()),
      );
      final expectedKeys = requestExample('/create_friends')!.keys;
      expect(json.keys.toSet(), expectedKeys.toSet());
      expect(json['users__0__first_name'], 'Alan');
      expect(json['users__1__email'], 'existing_user@example.com');
    });
  });

  group('UpdateUserRequest', () {
    test('sends only set fields with documented names', () {
      final json = const UpdateUserRequest(
        firstName: 'Ada',
        defaultCurrency: 'GBP',
      ).toJson();
      expect(json, {'first_name': 'Ada', 'default_currency': 'GBP'});
      expect(
        json.keys.toSet().difference(
          propertyKeys(requestSchema('/update_user/{id}')),
        ),
        isEmpty,
      );
    });
  });

  group('flattenUsers', () {
    test('indexes entries in order', () {
      expect(
        flattenUsers([
          {'a': 1},
          {'b': 'two'},
        ]),
        {'users__0__a': 1, 'users__1__b': 'two'},
      );
    });
  });
}
