import 'package:json_annotation/json_annotation.dart';

import 'balance.dart';
import 'category.dart';
import 'comment.dart';
import 'enums.dart';
import 'user.dart';

part 'expense.g.dart';

/// One user's share of an expense.
@JsonSerializable()
class ExpenseUser {
  /// Creates an expense share.
  const ExpenseUser({
    this.user,
    this.userId,
    this.paidShare,
    this.owedShare,
    this.netBalance,
  });

  /// Deserializes an expense share.
  factory ExpenseUser.fromJson(Map<String, dynamic> json) =>
      _$ExpenseUserFromJson(json);

  /// The user this share belongs to.
  final CommentUser? user;

  /// ID of the user this share belongs to.
  final int? userId;

  /// Decimal amount the user paid, as a string.
  final String? paidShare;

  /// Decimal amount the user owes, as a string.
  final String? owedShare;

  /// [paidShare] minus [owedShare], as a string.
  final String? netBalance;

  /// Serializes this expense share.
  Map<String, dynamic> toJson() => _$ExpenseUserToJson(this);
}

/// Receipt image attached to an expense.
@JsonSerializable()
class Receipt {
  /// Creates a receipt.
  const Receipt({this.large, this.original});

  /// Deserializes a receipt.
  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  /// URL of the large rendition.
  final String? large;

  /// URL of the original upload.
  final String? original;

  /// Serializes this receipt.
  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}

/// A Splitwise expense.
@JsonSerializable()
class Expense {
  /// Creates an expense.
  const Expense({
    required this.id,
    this.groupId,
    this.friendshipId,
    this.expenseBundleId,
    this.description,
    this.cost,
    this.details,
    this.date,
    this.repeatInterval,
    this.currencyCode,
    this.categoryId,
    this.repeats,
    this.emailReminder,
    this.emailReminderInAdvance,
    this.nextRepeat,
    this.commentsCount,
    this.payment,
    this.transactionConfirmed,
    this.repayments = const [],
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.deletedBy,
    this.category,
    this.receipt,
    this.users = const [],
    this.comments = const [],
  });

  /// Deserializes an expense.
  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  /// Unique identifier of the expense.
  final int id;

  /// ID of the group the expense belongs to; `null` when not in a group.
  final int? groupId;

  /// ID of the friendship the expense belongs to, for non-group expenses.
  final int? friendshipId;

  /// ID of the bundle of repeating expenses this one belongs to.
  final int? expenseBundleId;

  /// Short description of the expense.
  final String? description;

  /// Total cost as a decimal string.
  final String? cost;

  /// Free-form notes.
  final String? details;

  /// When the expense occurred.
  final DateTime? date;

  /// How often the expense repeats.
  @JsonKey(unknownEnumValue: RepeatInterval.unknown)
  final RepeatInterval? repeatInterval;

  /// ISO 4217 currency code of [cost].
  final String? currencyCode;

  /// ID of the expense's category.
  final int? categoryId;

  /// Whether the expense repeats.
  final bool? repeats;

  /// Whether an email reminder is sent before the next repetition.
  final bool? emailReminder;

  /// Days in advance of the next repetition the reminder is sent
  /// (`-1` = the day of).
  final int? emailReminderInAdvance;

  /// Date of the next repetition, as returned by the API.
  final String? nextRepeat;

  /// Number of comments on the expense.
  final int? commentsCount;

  /// Whether the expense is a payment rather than a shared cost.
  final bool? payment;

  /// Whether a payment has been confirmed by the recipient.
  final bool? transactionConfirmed;

  /// Repayments that settle the expense.
  final List<Repayment> repayments;

  /// When the expense was created.
  final DateTime? createdAt;

  /// The user who created the expense.
  final User? createdBy;

  /// When the expense was last updated.
  final DateTime? updatedAt;

  /// The user who last updated the expense.
  final User? updatedBy;

  /// When the expense was deleted, if it has been.
  final DateTime? deletedAt;

  /// The user who deleted the expense, if it has been.
  final User? deletedBy;

  /// The expense's category (only `id` and `name` are populated here).
  final SplitwiseCategory? category;

  /// Receipt image attached to the expense.
  final Receipt? receipt;

  /// Each user's share of the expense.
  final List<ExpenseUser> users;

  /// Comments on the expense.
  final List<Comment> comments;

  /// Serializes this expense.
  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
