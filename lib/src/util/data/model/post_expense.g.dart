// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostExpense _$PostExpenseFromJson(Map<String, dynamic> json) {
  return PostExpense(
    expense: json['expense'] == null
        ? null
        : PostExpenseBean.fromJson(json['expense'] as Map<String, dynamic>),
    errors: json['errors'],
  );
}

Map<String, dynamic> _$PostExpenseToJson(PostExpense instance) =>
    <String, dynamic>{
      'expense': instance.expense,
      'errors': instance.errors,
    };

PostExpenseBean _$PostExpenseBeanFromJson(Map<String, dynamic> json) {
  return PostExpenseBean(
    id: json['id'] as num,
    group_id: json['group_id'] as num,
    friendship_id: json['friendship_id'],
    expense_bundle_id: json['expense_bundle_id'],
    description: json['description'] as String,
    repeats: json['repeats'] as bool,
    repeat_interval: json['repeat_interval'] as String,
    email_reminder: json['email_reminder'] as bool,
    email_reminder_in_advance: json['email_reminder_in_advance'],
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
            : PostExpenseRepaymentsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    date: json['date'] as String,
    created_at: json['created_at'] as String,
    created_by: json['created_by'] == null
        ? null
        : PostExpenseCreated_byBean.fromJson(
            json['created_by'] as Map<String, dynamic>),
    updated_at: json['updated_at'] as String,
    updated_by: json['updated_by'] == null
        ? null
        : PostExpenseUpdated_byBean.fromJson(
            json['updated_by'] as Map<String, dynamic>),
    deleted_at: json['deleted_at'],
    deleted_by: json['deleted_by'],
    category: json['category'] == null
        ? null
        : PostExpenseCategoryBean.fromJson(
            json['category'] as Map<String, dynamic>),
    receipt: json['receipt'] == null
        ? null
        : PostExpenseReceiptBean.fromJson(
            json['receipt'] as Map<String, dynamic>),
    users: (json['users'] as List)
        ?.map((e) => e == null
            ? null
            : PostExpenseUsersBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    comments: (json['comments'] as List)
        ?.map((e) => e == null
            ? null
            : PostExpenseCommentsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PostExpenseBeanToJson(PostExpenseBean instance) =>
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
      'comments': instance.comments,
    };

PostExpenseCommentsBean _$PostExpenseCommentsBeanFromJson(
    Map<String, dynamic> json) {
  return PostExpenseCommentsBean(
    id: json['id'] as num,
    content: json['content'] as String,
    comment_type: json['comment_type'] as String,
    relation_type: json['relation_type'] as String,
    relation_id: json['relation_id'] as num,
    created_at: json['created_at'] as String,
    deleted_at: json['deleted_at'],
    user: json['user'] == null
        ? null
        : PostExpenseUserBean.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostExpenseCommentsBeanToJson(
        PostExpenseCommentsBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'comment_type': instance.comment_type,
      'relation_type': instance.relation_type,
      'relation_id': instance.relation_id,
      'created_at': instance.created_at,
      'deleted_at': instance.deleted_at,
      'user': instance.user,
    };

PostExpenseUsersBean _$PostExpenseUsersBeanFromJson(Map<String, dynamic> json) {
  return PostExpenseUsersBean(
    user: json['user'] == null
        ? null
        : PostExpenseUserBean.fromJson(json['user'] as Map<String, dynamic>),
    user_id: json['user_id'] as num,
    paid_share: json['paid_share'] as String,
    owed_share: json['owed_share'] as String,
    net_balance: json['net_balance'] as String,
  );
}

Map<String, dynamic> _$PostExpenseUsersBeanToJson(
        PostExpenseUsersBean instance) =>
    <String, dynamic>{
      'user': instance.user,
      'user_id': instance.user_id,
      'paid_share': instance.paid_share,
      'owed_share': instance.owed_share,
      'net_balance': instance.net_balance,
    };

PostExpenseUserBean _$PostExpenseUserBeanFromJson(Map<String, dynamic> json) {
  return PostExpenseUserBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : PostExpensePictureBean.fromJson(
            json['picture'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostExpenseUserBeanToJson(
        PostExpenseUserBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
    };

PostExpenseReceiptBean _$PostExpenseReceiptBeanFromJson(
    Map<String, dynamic> json) {
  return PostExpenseReceiptBean(
    large: json['large'],
    original: json['original'],
  );
}

Map<String, dynamic> _$PostExpenseReceiptBeanToJson(
        PostExpenseReceiptBean instance) =>
    <String, dynamic>{
      'large': instance.large,
      'original': instance.original,
    };

PostExpenseCategoryBean _$PostExpenseCategoryBeanFromJson(
    Map<String, dynamic> json) {
  return PostExpenseCategoryBean(
    id: json['id'] as num,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$PostExpenseCategoryBeanToJson(
        PostExpenseCategoryBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

PostExpenseUpdated_byBean _$PostExpenseUpdated_byBeanFromJson(
    Map<String, dynamic> json) {
  return PostExpenseUpdated_byBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : PostExpensePictureBean.fromJson(
            json['picture'] as Map<String, dynamic>),
    custom_picture: json['custom_picture'] as bool,
  );
}

Map<String, dynamic> _$PostExpenseUpdated_byBeanToJson(
        PostExpenseUpdated_byBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
      'custom_picture': instance.custom_picture,
    };

PostExpenseCreated_byBean _$PostExpenseCreated_byBeanFromJson(
    Map<String, dynamic> json) {
  return PostExpenseCreated_byBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : PostExpensePictureBean.fromJson(
            json['picture'] as Map<String, dynamic>),
    custom_picture: json['custom_picture'] as bool,
  );
}

Map<String, dynamic> _$PostExpenseCreated_byBeanToJson(
        PostExpenseCreated_byBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
      'custom_picture': instance.custom_picture,
    };

PostExpensePictureBean _$PostExpensePictureBeanFromJson(
    Map<String, dynamic> json) {
  return PostExpensePictureBean(
    medium: json['medium'] as String,
  );
}

Map<String, dynamic> _$PostExpensePictureBeanToJson(
        PostExpensePictureBean instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };

PostExpenseRepaymentsBean _$PostExpenseRepaymentsBeanFromJson(
    Map<String, dynamic> json) {
  return PostExpenseRepaymentsBean(
    from: json['from'] as num,
    to: json['to'] as num,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$PostExpenseRepaymentsBeanToJson(
        PostExpenseRepaymentsBean instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
    };
