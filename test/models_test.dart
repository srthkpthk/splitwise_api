import 'package:splitwise_api/splitwise_api.dart';
import 'package:test/test.dart';

import 'support/spec_examples.dart';

typedef _RoundTrip = Map<String, dynamic> Function(Map<String, dynamic> json);

class _Case {
  const _Case(this.schema, this.roundTrip, {this.minimal = const {'id': 1}});

  /// The merged spec schema the model represents.
  final Map<String, dynamic> schema;

  /// `fromJson` followed by `toJson`.
  final _RoundTrip roundTrip;

  /// The smallest JSON object the model must accept.
  final Map<String, dynamic> minimal;
}

void main() {
  final cases = <String, _Case>{
    'User': _Case(componentSchema('user'), (j) => User.fromJson(j).toJson()),
    'CurrentUser': _Case(
      componentSchema('current_user'),
      (j) => CurrentUser.fromJson(j).toJson(),
    ),
    'ImageSet': _Case(
      componentSchema('group', ['avatar']),
      (j) => ImageSet.fromJson(j).toJson(),
      minimal: const {},
    ),
    'Balance': _Case(
      componentSchema('balance'),
      (j) => Balance.fromJson(j).toJson(),
      minimal: const {},
    ),
    'Debt': _Case(
      componentSchema('debt'),
      (j) => Debt.fromJson(j).toJson(),
      minimal: const {},
    ),
    'Repayment': _Case(
      componentSchema('expense', ['repayments', 'items']),
      (j) => Repayment.fromJson(j).toJson(),
      minimal: const {},
    ),
    'GroupMember': _Case(
      componentSchema('group', ['members', 'items']),
      (j) => GroupMember.fromJson(j).toJson(),
    ),
    'Group': _Case(componentSchema('group'), (j) => Group.fromJson(j).toJson()),
    'FriendGroupBalance': _Case(
      componentSchema('friend', ['groups', 'items']),
      (j) => FriendGroupBalance.fromJson(j).toJson(),
      minimal: const {},
    ),
    'Friend': _Case(
      componentSchema('friend'),
      (j) => Friend.fromJson(j).toJson(),
    ),
    'Currency': _Case(
      responseSchema('/get_currencies', 'get', ['currencies', 'items']),
      (j) => Currency.fromJson(j).toJson(),
      minimal: const {},
    ),
    'CommentUser': _Case(
      componentSchema('comment_user'),
      (j) => CommentUser.fromJson(j).toJson(),
    ),
    'Comment': _Case(
      componentSchema('comment'),
      (j) => Comment.fromJson(j).toJson(),
    ),
    'ExpenseUser': _Case(
      componentSchema('share'),
      (j) => ExpenseUser.fromJson(j).toJson(),
      minimal: const {},
    ),
    'Receipt': _Case(
      componentSchema('expense', ['receipt']),
      (j) => Receipt.fromJson(j).toJson(),
      minimal: const {},
    ),
    'Expense': _Case(
      componentSchema('expense'),
      (j) => Expense.fromJson(j).toJson(),
    ),
    'NotificationSource': _Case(
      componentSchema('notification', ['source']),
      (j) => NotificationSource.fromJson(j).toJson(),
      minimal: const {},
    ),
    'SplitwiseNotification': _Case(
      componentSchema('notification'),
      (j) => SplitwiseNotification.fromJson(j).toJson(),
    ),
    'IconSizes': _Case(
      componentSchema('category', ['icon_types', 'slim']),
      (j) => IconSizes.fromJson(j).toJson(),
      minimal: const {},
    ),
    'IconTypes': _Case(
      componentSchema('category', ['icon_types']),
      (j) => IconTypes.fromJson(j).toJson(),
      minimal: const {},
    ),
    'SplitwiseCategory': _Case(
      componentSchema('category'),
      (j) => SplitwiseCategory.fromJson(j).toJson(),
    ),
    'SplitwiseParentCategory': _Case(
      componentSchema('parent_category'),
      (j) => SplitwiseParentCategory.fromJson(j).toJson(),
    ),
  };

  for (final entry in cases.entries) {
    final name = entry.key;
    final c = entry.value;
    final example = exampleOf(c.schema) as Map<String, dynamic>;

    group(name, () {
      test('parses the spec example', () {
        expect(c.roundTrip(example), isNotEmpty);
      });

      test('accepts a minimal object (nullability policy)', () {
        expect(() => c.roundTrip(c.minimal), returnsNormally);
      });

      test('serialises only documented keys', () {
        final undocumented = c
            .roundTrip(example)
            .keys
            .toSet()
            .difference(propertyKeys(c.schema));
        expect(undocumented, isEmpty);
      });

      test('round-trips through toJson/fromJson', () {
        final once = c.roundTrip(example);
        final twice = c.roundTrip(once);
        expect(twice, equals(once));
      });
    });
  }

  group('enums', () {
    test('unknown wire values map to the unknown member', () {
      final user = User.fromJson({'id': 1, 'registration_status': 'martian'});
      expect(user.registrationStatus, RegistrationStatus.unknown);

      final group = Group.fromJson({'id': 1, 'group_type': 'spaceship'});
      expect(group.groupType, GroupType.unknown);

      final comment = Comment.fromJson({
        'id': 1,
        'comment_type': 'Robot',
        'relation_type': 'GroupComment',
      });
      expect(comment.commentType, CommentType.unknown);
      expect(comment.relationType, RelationType.unknown);
    });

    test('documented values decode and encode with their wire names', () {
      final comment = Comment.fromJson({'id': 1, 'comment_type': 'System'});
      expect(comment.commentType, CommentType.system);
      expect(comment.toJson()['comment_type'], 'System');
      expect(GroupType.apartment.wireName, 'apartment');
      expect(RepeatInterval.fortnightly.wireName, 'fortnightly');
    });
  });

  group('dates', () {
    test('parse ISO 8601 and re-emit as UTC', () {
      final group = Group.fromJson({
        'id': 1,
        'updated_at': '2012-05-02T13:00:00Z',
      });
      expect(group.updatedAt, DateTime.utc(2012, 5, 2, 13));
      expect(group.toJson()['updated_at'], '2012-05-02T13:00:00.000Z');
    });

    test('offsets are honoured', () {
      final expense = Expense.fromJson({
        'id': 1,
        'date': '2012-05-02T15:00:00+02:00',
      });
      expect(expense.date, DateTime.utc(2012, 5, 2, 13));
    });
  });

  group('inheritance', () {
    test('subclasses carry the inherited User fields both ways', () {
      final json = exampleOf(componentSchema('friend')) as Map<String, dynamic>;
      final friend = Friend.fromJson(json);
      expect(friend, isA<User>());
      expect(friend.firstName, json['first_name']);
      expect(friend.email, json['email']);
      expect(friend.groups, isNotEmpty);
      final out = friend.toJson();
      expect(out['first_name'], json['first_name']);
      expect(out['groups'], isA<List<dynamic>>());
    });

    test('CurrentUser exposes notification settings as a map', () {
      final json =
          exampleOf(componentSchema('current_user')) as Map<String, dynamic>;
      final me = CurrentUser.fromJson(json);
      expect(me.notifications, isA<Map<String, bool>>());
      expect(me.notifications, isNotEmpty);
      expect(me.notificationsRead, isA<DateTime>());
    });

    test('ParentCategory keeps subcategories', () {
      final json =
          exampleOf(componentSchema('parent_category')) as Map<String, dynamic>;
      final parent = SplitwiseParentCategory.fromJson(json);
      expect(parent, isA<SplitwiseCategory>());
      expect(parent.subcategories, isNotEmpty);
      expect(parent.toJson().containsKey('subcategories'), isTrue);
    });
  });

  group('OAuth2Token', () {
    test('round-trips and derives expiry from expires_in', () {
      final now = DateTime.utc(2024, 1, 1);
      final token = OAuth2Token.fromJson({
        'access_token': 'abc',
        'token_type': 'bearer',
        'expires_in': 3600,
      }, now: now);
      expect(token.accessToken, 'abc');
      expect(token.expiresAt, DateTime.utc(2024, 1, 1, 1));
      final restored = OAuth2Token.fromJson(token.toJson());
      expect(restored.accessToken, 'abc');
      expect(restored.expiresAt, token.expiresAt);
      expect(token.toString(), isNot(contains('abc')));
    });

    test('rejects a body without access_token', () {
      expect(
        () => OAuth2Token.fromJson({'token_type': 'bearer'}),
        throwsFormatException,
      );
    });
  });
}
