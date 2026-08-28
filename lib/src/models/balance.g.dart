// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
  currencyCode: json['currency_code'] as String?,
  amount: json['amount'] as String?,
);

Map<String, dynamic> _$BalanceToJson(Balance instance) => <String, dynamic>{
  'currency_code': ?instance.currencyCode,
  'amount': ?instance.amount,
};

Debt _$DebtFromJson(Map<String, dynamic> json) => Debt(
  from: (json['from'] as num?)?.toInt(),
  to: (json['to'] as num?)?.toInt(),
  amount: json['amount'] as String?,
  currencyCode: json['currency_code'] as String?,
);

Map<String, dynamic> _$DebtToJson(Debt instance) => <String, dynamic>{
  'from': ?instance.from,
  'to': ?instance.to,
  'amount': ?instance.amount,
  'currency_code': ?instance.currencyCode,
};

Repayment _$RepaymentFromJson(Map<String, dynamic> json) => Repayment(
  from: (json['from'] as num?)?.toInt(),
  to: (json['to'] as num?)?.toInt(),
  amount: json['amount'] as String?,
);

Map<String, dynamic> _$RepaymentToJson(Repayment instance) => <String, dynamic>{
  'from': ?instance.from,
  'to': ?instance.to,
  'amount': ?instance.amount,
};
