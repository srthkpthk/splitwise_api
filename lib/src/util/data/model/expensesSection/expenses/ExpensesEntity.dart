import 'package:splitwise_api/src/util/data/model/expensesSection/expenses/expenses.dart';

class ExpensesEntity {

  final List<Expenses> expenses;

	ExpensesEntity.fromJsonMap(Map<String, dynamic> map): 
		expenses = List<Expenses>.from(map["expenses"].map((it) => Expenses.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['expenses'] = expenses != null ? 
			this.expenses.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
