import 'package:json_annotation/json_annotation.dart';

part 'post_expense.g.dart';

@JsonSerializable()
class PostExpense {
  PostExpenseBean expense;
  dynamic errors;

  PostExpense({this.expense, this.errors});

  factory PostExpense.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseToJson(this);
}

@JsonSerializable()
class PostExpenseBean {
  num id;
  num group_id;
  dynamic friendship_id;
  dynamic expense_bundle_id;
  String description;
  bool repeats;
  String repeat_interval;
  bool email_reminder;
  dynamic email_reminder_in_advance;
  dynamic next_repeat;
  String details;
  num comments_count;
  bool payment;
  String creation_method;
  String transaction_method;
  bool transaction_confirmed;
  dynamic transaction_id;
  String cost;
  String currency_code;
  List<PostExpenseRepaymentsBean> repayments;
  String date;
  String created_at;
  PostExpenseCreated_byBean created_by;
  String updated_at;
  PostExpenseUpdated_byBean updated_by;
  dynamic deleted_at;
  dynamic deleted_by;
  PostExpenseCategoryBean category;
  PostExpenseReceiptBean receipt;
  List<PostExpenseUsersBean> users;
  List<PostExpenseCommentsBean> comments;

  PostExpenseBean(
      {this.id,
      this.group_id,
      this.friendship_id,
      this.expense_bundle_id,
      this.description,
      this.repeats,
      this.repeat_interval,
      this.email_reminder,
      this.email_reminder_in_advance,
      this.next_repeat,
      this.details,
      this.comments_count,
      this.payment,
      this.creation_method,
      this.transaction_method,
      this.transaction_confirmed,
      this.transaction_id,
      this.cost,
      this.currency_code,
      this.repayments,
      this.date,
      this.created_at,
      this.created_by,
      this.updated_at,
      this.updated_by,
      this.deleted_at,
      this.deleted_by,
      this.category,
      this.receipt,
      this.users,
      this.comments});

  factory PostExpenseBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseBeanToJson(this);
}

@JsonSerializable()
class PostExpenseCommentsBean {
  num id;
  String content;
  String comment_type;
  String relation_type;
  num relation_id;
  String created_at;
  dynamic deleted_at;
  PostExpenseUserBean user;

  PostExpenseCommentsBean(
      {this.id,
      this.content,
      this.comment_type,
      this.relation_type,
      this.relation_id,
      this.created_at,
      this.deleted_at,
      this.user});

  factory PostExpenseCommentsBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseCommentsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseCommentsBeanToJson(this);
}

@JsonSerializable()
class PostExpenseUsersBean {
  PostExpenseUserBean user;
  num user_id;
  String paid_share;
  String owed_share;
  String net_balance;

  PostExpenseUsersBean(
      {this.user,
      this.user_id,
      this.paid_share,
      this.owed_share,
      this.net_balance});

  factory PostExpenseUsersBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseUsersBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseUsersBeanToJson(this);
}

@JsonSerializable()
class PostExpenseUserBean {
  num id;
  String first_name;
  String last_name;
  PostExpensePictureBean picture;

  PostExpenseUserBean({this.id, this.first_name, this.last_name, this.picture});

  factory PostExpenseUserBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseUserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseUserBeanToJson(this);
}

@JsonSerializable()
class PostExpenseReceiptBean {
  dynamic large;
  dynamic original;

  PostExpenseReceiptBean({this.large, this.original});

  factory PostExpenseReceiptBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseReceiptBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseReceiptBeanToJson(this);
}

@JsonSerializable()
class PostExpenseCategoryBean {
  num id;
  String name;

  PostExpenseCategoryBean({this.id, this.name});

  factory PostExpenseCategoryBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseCategoryBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseCategoryBeanToJson(this);
}

@JsonSerializable()
class PostExpenseUpdated_byBean {
  num id;
  String first_name;
  String last_name;
  PostExpensePictureBean picture;
  bool custom_picture;

  PostExpenseUpdated_byBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.picture,
      this.custom_picture});

  factory PostExpenseUpdated_byBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseUpdated_byBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseUpdated_byBeanToJson(this);
}

@JsonSerializable()
class PostExpenseCreated_byBean {
  num id;
  String first_name;
  String last_name;
  PostExpensePictureBean picture;
  bool custom_picture;

  PostExpenseCreated_byBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.picture,
      this.custom_picture});

  factory PostExpenseCreated_byBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseCreated_byBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseCreated_byBeanToJson(this);
}

@JsonSerializable()
class PostExpensePictureBean {
  String medium;

  PostExpensePictureBean({this.medium});

  factory PostExpensePictureBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpensePictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpensePictureBeanToJson(this);
}

@JsonSerializable()
class PostExpenseRepaymentsBean {
  num from;
  num to;
  String amount;

  PostExpenseRepaymentsBean({this.from, this.to, this.amount});

  factory PostExpenseRepaymentsBean.fromJson(Map<String, dynamic> json) =>
      _$PostExpenseRepaymentsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PostExpenseRepaymentsBeanToJson(this);
}
