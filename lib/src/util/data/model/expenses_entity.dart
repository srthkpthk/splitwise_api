import 'package:json_annotation/json_annotation.dart';

part 'expenses_entity.g.dart';

@JsonSerializable()
class ExpensesEntity {
  List<ExpensesBean> expenses;

  ExpensesEntity({this.expenses});

  factory ExpensesEntity.fromJson(Map<String, dynamic> json) =>
      _$ExpensesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesEntityToJson(this);
}

@JsonSerializable()
class ExpensesBean {
  num id;
  dynamic group_id;
  dynamic friendship_id;
  dynamic expense_bundle_id;
  String description;
  bool repeats;
  String repeat_interval;
  bool email_reminder;
  num email_reminder_in_advance;
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
  List<ExpensesRepaymentsBean> repayments;
  String date;
  String created_at;
  ExpensesCreated_byBean created_by;
  String updated_at;
  dynamic updated_by;
  dynamic deleted_at;
  dynamic deleted_by;
  ExpensesCategoryBean category;
  ExpensesReceiptBean receipt;
  List<ExpensesUsersBean> users;

  ExpensesBean(
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
      this.users});

  factory ExpensesBean.fromJson(Map<String, dynamic> json) =>
      _$ExpensesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesBeanToJson(this);
}

@JsonSerializable()
class ExpensesUsersBean {
  ExpensesUserBean user;
  num user_id;
  String paid_share;
  String owed_share;
  String net_balance;

  ExpensesUsersBean(
      {this.user,
      this.user_id,
      this.paid_share,
      this.owed_share,
      this.net_balance});

  factory ExpensesUsersBean.fromJson(Map<String, dynamic> json) =>
      _$ExpensesUsersBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesUsersBeanToJson(this);
}

@JsonSerializable()
class ExpensesUserBean {
  num id;
  String first_name;
  String last_name;
  ExpensesPictureBean picture;

  ExpensesUserBean({this.id, this.first_name, this.last_name, this.picture});

  factory ExpensesUserBean.fromJson(Map<String, dynamic> json) =>
      _$ExpensesUserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesUserBeanToJson(this);
}

@JsonSerializable()
class ExpensesReceiptBean {
  dynamic large;
  dynamic original;

  ExpensesReceiptBean({this.large, this.original});

  factory ExpensesReceiptBean.fromJson(Map<String, dynamic> json) =>
      _$ExpensesReceiptBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesReceiptBeanToJson(this);
}

@JsonSerializable()
class ExpensesCategoryBean {
  num id;
  String name;

  ExpensesCategoryBean({this.id, this.name});

  factory ExpensesCategoryBean.fromJson(Map<String, dynamic> json) =>
      _$ExpensesCategoryBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesCategoryBeanToJson(this);
}

@JsonSerializable()
class ExpensesCreated_byBean {
  num id;
  String first_name;
  dynamic last_name;
  ExpensesPictureBean picture;
  bool custom_picture;

  ExpensesCreated_byBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.picture,
      this.custom_picture});

  factory ExpensesCreated_byBean.fromJson(Map<String, dynamic> json) =>
      _$ExpensesCreated_byBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesCreated_byBeanToJson(this);
}

@JsonSerializable()
class ExpensesPictureBean {
  String medium;

  ExpensesPictureBean({this.medium});

  factory ExpensesPictureBean.fromJson(Map<String, dynamic> json) =>
      _$ExpensesPictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesPictureBeanToJson(this);
}

@JsonSerializable()
class ExpensesRepaymentsBean {
  num from;
  num to;
  String amount;

  ExpensesRepaymentsBean({this.from, this.to, this.amount});

  factory ExpensesRepaymentsBean.fromJson(Map<String, dynamic> json) =>
      _$ExpensesRepaymentsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExpensesRepaymentsBeanToJson(this);
}
