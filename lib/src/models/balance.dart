import 'package:json_annotation/json_annotation.dart';

part 'balance.g.dart';

/// An amount owed in a single currency.
@JsonSerializable()
class Balance {
  /// Creates a balance.
  const Balance({this.currencyCode, this.amount});

  /// Deserializes a balance.
  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);

  /// ISO 4217 currency code.
  final String? currencyCode;

  /// Decimal amount as a string (negative when the user owes money).
  final String? amount;

  /// Serializes this balance.
  Map<String, dynamic> toJson() => _$BalanceToJson(this);
}

/// A debt between two members of a group.
@JsonSerializable()
class Debt {
  /// Creates a debt.
  const Debt({this.from, this.to, this.amount, this.currencyCode});

  /// Deserializes a debt.
  factory Debt.fromJson(Map<String, dynamic> json) => _$DebtFromJson(json);

  /// ID of the user who owes.
  final int? from;

  /// ID of the user who is owed.
  final int? to;

  /// Decimal amount as a string.
  final String? amount;

  /// ISO 4217 currency code.
  final String? currencyCode;

  /// Serializes this debt.
  Map<String, dynamic> toJson() => _$DebtToJson(this);
}

/// A repayment between two users that settles part of an expense.
@JsonSerializable()
class Repayment {
  /// Creates a repayment.
  const Repayment({this.from, this.to, this.amount});

  /// Deserializes a repayment.
  factory Repayment.fromJson(Map<String, dynamic> json) =>
      _$RepaymentFromJson(json);

  /// ID of the user who pays.
  final int? from;

  /// ID of the user who is paid.
  final int? to;

  /// Decimal amount as a string.
  final String? amount;

  /// Serializes this repayment.
  Map<String, dynamic> toJson() => _$RepaymentToJson(this);
}
