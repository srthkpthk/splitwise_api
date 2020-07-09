import 'package:splitwise_api/splitwise_api.dart';

class PostExpenseEntity {
  Expenses expense;
  String error;

  PostExpenseEntity({this.expense, this.error});

  factory PostExpenseEntity.fromMap(Map<String, dynamic> map) {
    return new PostExpenseEntity(
      expense: map['expense'] as Expenses,
      error: map['error'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'expense': this.expense,
      'error': this.error,
    } as Map<String, dynamic>;
  }
}
