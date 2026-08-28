// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseUser _$ExpenseUserFromJson(Map<String, dynamic> json) => ExpenseUser(
  user: json['user'] == null
      ? null
      : CommentUser.fromJson(json['user'] as Map<String, dynamic>),
  userId: (json['user_id'] as num?)?.toInt(),
  paidShare: json['paid_share'] as String?,
  owedShare: json['owed_share'] as String?,
  netBalance: json['net_balance'] as String?,
);

Map<String, dynamic> _$ExpenseUserToJson(ExpenseUser instance) =>
    <String, dynamic>{
      'user': ?instance.user?.toJson(),
      'user_id': ?instance.userId,
      'paid_share': ?instance.paidShare,
      'owed_share': ?instance.owedShare,
      'net_balance': ?instance.netBalance,
    };

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
  large: json['large'] as String?,
  original: json['original'] as String?,
);

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
  'large': ?instance.large,
  'original': ?instance.original,
};

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
  id: (json['id'] as num).toInt(),
  groupId: (json['group_id'] as num?)?.toInt(),
  friendshipId: (json['friendship_id'] as num?)?.toInt(),
  expenseBundleId: (json['expense_bundle_id'] as num?)?.toInt(),
  description: json['description'] as String?,
  cost: json['cost'] as String?,
  details: json['details'] as String?,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  repeatInterval: $enumDecodeNullable(
    _$RepeatIntervalEnumMap,
    json['repeat_interval'],
    unknownValue: RepeatInterval.unknown,
  ),
  currencyCode: json['currency_code'] as String?,
  categoryId: (json['category_id'] as num?)?.toInt(),
  repeats: json['repeats'] as bool?,
  emailReminder: json['email_reminder'] as bool?,
  emailReminderInAdvance: (json['email_reminder_in_advance'] as num?)?.toInt(),
  nextRepeat: json['next_repeat'] as String?,
  commentsCount: (json['comments_count'] as num?)?.toInt(),
  payment: json['payment'] as bool?,
  transactionConfirmed: json['transaction_confirmed'] as bool?,
  repayments:
      (json['repayments'] as List<dynamic>?)
          ?.map((e) => Repayment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  createdBy: json['created_by'] == null
      ? null
      : User.fromJson(json['created_by'] as Map<String, dynamic>),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  updatedBy: json['updated_by'] == null
      ? null
      : User.fromJson(json['updated_by'] as Map<String, dynamic>),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  deletedBy: json['deleted_by'] == null
      ? null
      : User.fromJson(json['deleted_by'] as Map<String, dynamic>),
  category: json['category'] == null
      ? null
      : SplitwiseCategory.fromJson(json['category'] as Map<String, dynamic>),
  receipt: json['receipt'] == null
      ? null
      : Receipt.fromJson(json['receipt'] as Map<String, dynamic>),
  users:
      (json['users'] as List<dynamic>?)
          ?.map((e) => ExpenseUser.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  comments:
      (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
  'id': instance.id,
  'group_id': ?instance.groupId,
  'friendship_id': ?instance.friendshipId,
  'expense_bundle_id': ?instance.expenseBundleId,
  'description': ?instance.description,
  'cost': ?instance.cost,
  'details': ?instance.details,
  'date': ?instance.date?.toUtc().toIso8601String(),
  'repeat_interval': ?_$RepeatIntervalEnumMap[instance.repeatInterval],
  'currency_code': ?instance.currencyCode,
  'category_id': ?instance.categoryId,
  'repeats': ?instance.repeats,
  'email_reminder': ?instance.emailReminder,
  'email_reminder_in_advance': ?instance.emailReminderInAdvance,
  'next_repeat': ?instance.nextRepeat,
  'comments_count': ?instance.commentsCount,
  'payment': ?instance.payment,
  'transaction_confirmed': ?instance.transactionConfirmed,
  'repayments': instance.repayments.map((e) => e.toJson()).toList(),
  'created_at': ?instance.createdAt?.toUtc().toIso8601String(),
  'created_by': ?instance.createdBy?.toJson(),
  'updated_at': ?instance.updatedAt?.toUtc().toIso8601String(),
  'updated_by': ?instance.updatedBy?.toJson(),
  'deleted_at': ?instance.deletedAt?.toUtc().toIso8601String(),
  'deleted_by': ?instance.deletedBy?.toJson(),
  'category': ?instance.category?.toJson(),
  'receipt': ?instance.receipt?.toJson(),
  'users': instance.users.map((e) => e.toJson()).toList(),
  'comments': instance.comments.map((e) => e.toJson()).toList(),
};

const _$RepeatIntervalEnumMap = {
  RepeatInterval.never: 'never',
  RepeatInterval.weekly: 'weekly',
  RepeatInterval.fortnightly: 'fortnightly',
  RepeatInterval.monthly: 'monthly',
  RepeatInterval.yearly: 'yearly',
  RepeatInterval.unknown: 'unknown',
};
