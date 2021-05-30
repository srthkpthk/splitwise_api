import 'package:splitwise_api/src/util/data/model/ExpensesEntity/expenses.dart';

class ExpensesEntity {

  final List<ExpenseEntity> expenses;

	ExpensesEntity.fromJsonMap(Map<String, dynamic> map): 
		expenses = List<ExpenseEntity>.from(map["expenses"].map((it) => ExpenseEntity.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['expenses'] = expenses != null ? 
			this.expenses.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
