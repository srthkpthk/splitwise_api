import 'package:splitwise_api/src/util/data/model/PostExpense/expenses.dart';
import 'package:splitwise_api/src/util/data/model/PostExpense/errors.dart';

class PostExpense {

  final List<Expenses> expenses;
  final Errors errors;

	PostExpense.fromJsonMap(Map<String, dynamic> map): 
		expenses = List<Expenses>.from(map["expenses"].map((it) => Expenses.fromJsonMap(it))),
		errors = Errors.fromJsonMap(map["errors"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['expenses'] = expenses != null ? 
			this.expenses.map((v) => v.toJson()).toList()
			: null;
		data['errors'] = errors == null ? null : errors.toJson();
		return data;
	}
}
