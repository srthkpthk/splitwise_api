// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpensesEntity _$ExpensesEntityFromJson(Map<String, dynamic> json) {
  return ExpensesEntity(
    expenses: (json['expenses'] as List)
        ?.map((e) =>
            e == null ? null : ExpensesBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExpensesEntityToJson(ExpensesEntity instance) =>
    <String, dynamic>{
      'expenses': instance.expenses,
    };

ExpensesBean _$ExpensesBeanFromJson(Map<String, dynamic> json) {
  return ExpensesBean(
    id: json['id'] as num,
    group_id: json['group_id'],
    friendship_id: json['friendship_id'],
    expense_bundle_id: json['expense_bundle_id'],
    description: json['description'] as String,
    repeats: json['repeats'] as bool,
    repeat_interval: json['repeat_interval'] as String,
    email_reminder: json['email_reminder'] as bool,
    email_reminder_in_advance: json['email_reminder_in_advance'] as num,
    next_repeat: json['next_repeat'],
    details: json['details'] as String,
    comments_count: json['comments_count'] as num,
    payment: json['payment'] as bool,
    creation_method: json['creation_method'] as String,
    transaction_method: json['transaction_method'] as String,
    transaction_confirmed: json['transaction_confirmed'] as bool,
    transaction_id: json['transaction_id'],
    cost: json['cost'] as String,
    currency_code: json['currency_code'] as String,
    repayments: (json['repayments'] as List)
        ?.map((e) => e == null
            ? null
            : ExpensesRepaymentsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    date: json['date'] as String,
    created_at: json['created_at'] as String,
    created_by: json['created_by'] == null
        ? null
        : ExpensesCreated_byBean.fromJson(
            json['created_by'] as Map<String, dynamic>),
    updated_at: json['updated_at'] as String,
    updated_by: json['updated_by'],
    deleted_at: json['deleted_at'],
    deleted_by: json['deleted_by'],
    category: json['category'] == null
        ? null
        : ExpensesCategoryBean.fromJson(
            json['category'] as Map<String, dynamic>),
    receipt: json['receipt'] == null
        ? null
        : ExpensesReceiptBean.fromJson(json['receipt'] as Map<String, dynamic>),
    users: (json['users'] as List)
        ?.map((e) => e == null
            ? null
            : ExpensesUsersBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExpensesBeanToJson(ExpensesBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.group_id,
      'friendship_id': instance.friendship_id,
      'expense_bundle_id': instance.expense_bundle_id,
      'description': instance.description,
      'repeats': instance.repeats,
      'repeat_interval': instance.repeat_interval,
      'email_reminder': instance.email_reminder,
      'email_reminder_in_advance': instance.email_reminder_in_advance,
      'next_repeat': instance.next_repeat,
      'details': instance.details,
      'comments_count': instance.comments_count,
      'payment': instance.payment,
      'creation_method': instance.creation_method,
      'transaction_method': instance.transaction_method,
      'transaction_confirmed': instance.transaction_confirmed,
      'transaction_id': instance.transaction_id,
      'cost': instance.cost,
      'currency_code': instance.currency_code,
      'repayments': instance.repayments,
      'date': instance.date,
      'created_at': instance.created_at,
      'created_by': instance.created_by,
      'updated_at': instance.updated_at,
      'updated_by': instance.updated_by,
      'deleted_at': instance.deleted_at,
      'deleted_by': instance.deleted_by,
      'category': instance.category,
      'receipt': instance.receipt,
      'users': instance.users,
    };

ExpensesUsersBean _$ExpensesUsersBeanFromJson(Map<String, dynamic> json) {
  return ExpensesUsersBean(
    user: json['user'] == null
        ? null
        : ExpensesUserBean.fromJson(json['user'] as Map<String, dynamic>),
    user_id: json['user_id'] as num,
    paid_share: json['paid_share'] as String,
    owed_share: json['owed_share'] as String,
    net_balance: json['net_balance'] as String,
  );
}

Map<String, dynamic> _$ExpensesUsersBeanToJson(ExpensesUsersBean instance) =>
    <String, dynamic>{
      'user': instance.user,
      'user_id': instance.user_id,
      'paid_share': instance.paid_share,
      'owed_share': instance.owed_share,
      'net_balance': instance.net_balance,
    };

ExpensesUserBean _$ExpensesUserBeanFromJson(Map<String, dynamic> json) {
  return ExpensesUserBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : ExpensesPictureBean.fromJson(json['picture'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ExpensesUserBeanToJson(ExpensesUserBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
    };

ExpensesReceiptBean _$ExpensesReceiptBeanFromJson(Map<String, dynamic> json) {
  return ExpensesReceiptBean(
    large: json['large'],
    original: json['original'],
  );
}

Map<String, dynamic> _$ExpensesReceiptBeanToJson(
        ExpensesReceiptBean instance) =>
    <String, dynamic>{
      'large': instance.large,
      'original': instance.original,
    };

ExpensesCategoryBean _$ExpensesCategoryBeanFromJson(Map<String, dynamic> json) {
  return ExpensesCategoryBean(
    id: json['id'] as num,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$ExpensesCategoryBeanToJson(
        ExpensesCategoryBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ExpensesCreated_byBean _$ExpensesCreated_byBeanFromJson(
    Map<String, dynamic> json) {
  return ExpensesCreated_byBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'],
    picture: json['picture'] == null
        ? null
        : ExpensesPictureBean.fromJson(json['picture'] as Map<String, dynamic>),
    custom_picture: json['custom_picture'] as bool,
  );
}

Map<String, dynamic> _$ExpensesCreated_byBeanToJson(
        ExpensesCreated_byBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
      'custom_picture': instance.custom_picture,
    };

ExpensesPictureBean _$ExpensesPictureBeanFromJson(Map<String, dynamic> json) {
  return ExpensesPictureBean(
    medium: json['medium'] as String,
  );
}

Map<String, dynamic> _$ExpensesPictureBeanToJson(
        ExpensesPictureBean instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };

ExpensesRepaymentsBean _$ExpensesRepaymentsBeanFromJson(
    Map<String, dynamic> json) {
  return ExpensesRepaymentsBean(
    from: json['from'] as num,
    to: json['to'] as num,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$ExpensesRepaymentsBeanToJson(
        ExpensesRepaymentsBean instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
    };
