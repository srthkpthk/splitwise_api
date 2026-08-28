import '../enums.dart';
import 'flatten.dart';

/// One user's share when creating or updating an expense by shares.
///
/// Amounts are decimal strings with at most two decimal places (for example
/// `'12.50'`). The sum of [paidShare] across all shares must equal the
/// expense cost, and so must the sum of [owedShare].
sealed class ExpenseShareInput {
  const ExpenseShareInput({required this.paidShare, required this.owedShare});

  /// A share for an existing Splitwise user identified by [userId].
  const factory ExpenseShareInput.user({
    required int userId,
    required String paidShare,
    required String owedShare,
  }) = ExistingUserShare;

  /// A share for a user identified by [email]; Splitwise invites them if they
  /// have no account yet.
  const factory ExpenseShareInput.newUser({
    required String email,
    required String firstName,
    required String lastName,
    required String paidShare,
    required String owedShare,
  }) = NewUserShare;

  /// Decimal amount this user paid, as a string.
  final String paidShare;

  /// Decimal amount this user owes, as a string.
  final String owedShare;

  /// Serializes this share to the properties Splitwise expects.
  Map<String, Object?> toJson();
}

/// An [ExpenseShareInput] for an existing user.
final class ExistingUserShare extends ExpenseShareInput {
  /// Creates a share by user ID.
  const ExistingUserShare({
    required this.userId,
    required super.paidShare,
    required super.owedShare,
  });

  /// ID of the existing user.
  final int userId;

  @override
  Map<String, Object?> toJson() => {
    'user_id': userId,
    'paid_share': paidShare,
    'owed_share': owedShare,
  };
}

/// An [ExpenseShareInput] for a user identified by email.
final class NewUserShare extends ExpenseShareInput {
  /// Creates a share by email.
  const NewUserShare({
    required this.email,
    required this.firstName,
    required this.lastName,
    required super.paidShare,
    required super.owedShare,
  });

  /// Email address of the user.
  final String email;

  /// First name, used if the user has no account yet.
  final String firstName;

  /// Last name, used if the user has no account yet.
  final String lastName;

  @override
  Map<String, Object?> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'paid_share': paidShare,
    'owed_share': owedShare,
  };
}

/// Payload for `create_expense`.
///
/// Use [EqualGroupSplit] to split a cost equally between all members of a
/// group, or [SplitByShares] to specify each user's paid and owed amounts.
sealed class CreateExpenseRequest {
  const CreateExpenseRequest({
    required this.cost,
    required this.description,
    this.details,
    this.date,
    this.repeatInterval,
    this.currencyCode,
    this.categoryId,
  });

  /// Total cost as a decimal string with at most two decimal places.
  final String cost;

  /// Short description of the expense.
  final String description;

  /// Free-form notes.
  final String? details;

  /// When the expense occurred; defaults to now on the server.
  final DateTime? date;

  /// How often the expense repeats.
  final RepeatInterval? repeatInterval;

  /// ISO 4217 currency code; defaults to the user's default currency.
  final String? currencyCode;

  /// ID of a category from `get_categories` (a subcategory, not a parent).
  final int? categoryId;

  /// Serializes the request.
  Map<String, Object?> toJson();

  Map<String, Object?> _commonJson() => {
    'cost': cost,
    'description': description,
    if (details != null) 'details': details,
    if (date != null) 'date': date!.toUtc().toIso8601String(),
    if (repeatInterval != null) 'repeat_interval': repeatInterval!.wireName,
    if (currencyCode != null) 'currency_code': currencyCode,
    if (categoryId != null) 'category_id': categoryId,
  };
}

/// A [CreateExpenseRequest] that splits [cost] equally between every member
/// of the group [groupId].
final class EqualGroupSplit extends CreateExpenseRequest {
  /// Creates an equal group split.
  const EqualGroupSplit({
    required super.cost,
    required super.description,
    required this.groupId,
    super.details,
    super.date,
    super.repeatInterval,
    super.currencyCode,
    super.categoryId,
  });

  /// The group whose members share the expense.
  final int groupId;

  @override
  Map<String, Object?> toJson() => {
    ..._commonJson(),
    'group_id': groupId,
    'split_equally': true,
  };
}

/// A [CreateExpenseRequest] with an explicit share for each user.
///
/// Shares are flattened to `users__{index}__{property}` keys.
final class SplitByShares extends CreateExpenseRequest {
  /// Creates an expense split by shares.
  ///
  /// Throws [ArgumentError] if [users] is empty.
  SplitByShares({
    required super.cost,
    required super.description,
    required this.users,
    this.groupId = 0,
    super.details,
    super.date,
    super.repeatInterval,
    super.currencyCode,
    super.categoryId,
  }) {
    if (users.isEmpty) {
      throw ArgumentError.value(users, 'users', 'must not be empty');
    }
  }

  /// The group to put the expense in, or `0` for an expense outside a group.
  final int groupId;

  /// Each participant's share.
  final List<ExpenseShareInput> users;

  @override
  Map<String, Object?> toJson() => {
    ..._commonJson(),
    'group_id': groupId,
    ...flattenUsers(users.map((user) => user.toJson())),
  };
}

/// Payload for `update_expense`.
///
/// Only non-null fields are sent, so an update changes just the fields you
/// set. If [users] is provided it replaces **all** existing shares.
final class UpdateExpenseRequest {
  /// Creates an update request.
  const UpdateExpenseRequest({
    this.cost,
    this.description,
    this.details,
    this.date,
    this.repeatInterval,
    this.currencyCode,
    this.categoryId,
    this.groupId,
    this.users,
  });

  /// New total cost as a decimal string.
  final String? cost;

  /// New description.
  final String? description;

  /// New notes.
  final String? details;

  /// New date.
  final DateTime? date;

  /// New repeat interval.
  final RepeatInterval? repeatInterval;

  /// New ISO 4217 currency code.
  final String? currencyCode;

  /// New category ID.
  final int? categoryId;

  /// New group ID (`0` moves the expense out of any group).
  final int? groupId;

  /// Replacement shares for every participant.
  final List<ExpenseShareInput>? users;

  /// Serializes the request, omitting unset fields.
  Map<String, Object?> toJson() => {
    if (cost != null) 'cost': cost,
    if (description != null) 'description': description,
    if (details != null) 'details': details,
    if (date != null) 'date': date!.toUtc().toIso8601String(),
    if (repeatInterval != null) 'repeat_interval': repeatInterval!.wireName,
    if (currencyCode != null) 'currency_code': currencyCode,
    if (categoryId != null) 'category_id': categoryId,
    if (groupId != null) 'group_id': groupId,
    if (users != null) ...flattenUsers(users!.map((user) => user.toJson())),
  };
}
