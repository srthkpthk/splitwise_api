// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
  currencyCode: json['currency_code'] as String?,
  unit: json['unit'] as String?,
);

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
  'currency_code': ?instance.currencyCode,
  'unit': ?instance.unit,
};
