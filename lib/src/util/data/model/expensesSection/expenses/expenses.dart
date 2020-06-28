import 'package:splitwise_api/src/util/data/model/common/created_by.dart';
import 'package:splitwise_api/src/util/data/model/expensesSection/expenses/repayments.dart';
import 'package:splitwise_api/src/util/data/model/common/category.dart';
import 'package:splitwise_api/src/util/data/model/expensesSection/expenses/receipt.dart';
import 'package:splitwise_api/src/util/data/model/expensesSection/postExpense/users.dart';

class Expenses {
  final int id;
  final Object group_id;
  final Object friendship_id;
  final Object expense_bundle_id;
  final String description;
  final bool repeats;
  final String repeat_interval;
  final bool email_reminder;
  final Object email_reminder_in_advance;
  final Object next_repeat;
  final String details;
  final int comments_count;
  final bool payment;
  final String creation_method;
  final String transaction_method;
  final bool transaction_confirmed;
  final Object transaction_id;
  final String cost;
  final String currency_code;
  final List<Repayments> repayments;
  final String date;
  final String created_at;
  final Created_by created_by;
  final String updated_at;
  final Object updated_by;
  final Object deleted_at;
  final Object deleted_by;
  final Category category;
  final Receipt receipt;
  final List<Users> users;

  Expenses.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        group_id = map["group_id"],
        friendship_id = map["friendship_id"],
        expense_bundle_id = map["expense_bundle_id"],
        description = map["description"],
        repeats = map["repeats"],
        repeat_interval = map["repeat_interval"],
        email_reminder = map["email_reminder"],
        email_reminder_in_advance = map["email_reminder_in_advance"],
        next_repeat = map["next_repeat"],
        details = map["details"],
        comments_count = map["comments_count"],
        payment = map["payment"],
        creation_method = map["creation_method"],
        transaction_method = map["transaction_method"],
        transaction_confirmed = map["transaction_confirmed"],
        transaction_id = map["transaction_id"],
        cost = map["cost"],
        currency_code = map["currency_code"],
        repayments = List<Repayments>.from(map["repayments"].map((it) => Repayments.fromJsonMap(it))),
        date = map["date"],
        created_at = map["created_at"],
        created_by = Created_by.fromJsonMap(map["created_by"]),
        updated_at = map["updated_at"],
        updated_by = map["updated_by"],
        deleted_at = map["deleted_at"],
        deleted_by = map["deleted_by"],
        category = Category.fromJsonMap(map["category"]),
        receipt = Receipt.fromJsonMap(map["receipt"]),
        users = List<Users>.from(map["users"].map((it) => Users.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['group_id'] = group_id;
    data['friendship_id'] = friendship_id;
    data['expense_bundle_id'] = expense_bundle_id;
    data['description'] = description;
    data['repeats'] = repeats;
    data['repeat_interval'] = repeat_interval;
    data['email_reminder'] = email_reminder;
    data['email_reminder_in_advance'] = email_reminder_in_advance;
    data['next_repeat'] = next_repeat;
    data['details'] = details;
    data['comments_count'] = comments_count;
    data['payment'] = payment;
    data['creation_method'] = creation_method;
    data['transaction_method'] = transaction_method;
    data['transaction_confirmed'] = transaction_confirmed;
    data['transaction_id'] = transaction_id;
    data['cost'] = cost;
    data['currency_code'] = currency_code;
    data['repayments'] = repayments != null ? this.repayments.map((v) => v.toJson()).toList() : null;
    data['date'] = date;
    data['created_at'] = created_at;
    data['created_by'] = created_by == null ? null : created_by.toJson();
    data['updated_at'] = updated_at;
    data['updated_by'] = updated_by;
    data['deleted_at'] = deleted_at;
    data['deleted_by'] = deleted_by;
    data['category'] = category == null ? null : category.toJson();
    data['receipt'] = receipt == null ? null : receipt.toJson();
    data['users'] = users != null ? this.users.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
