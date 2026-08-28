import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

/// A currency supported by Splitwise.
@JsonSerializable()
class Currency {
  /// Creates a currency.
  const Currency({this.currencyCode, this.unit});

  /// Deserializes a currency.
  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  /// ISO 4217 currency code (for example `USD`).
  final String? currencyCode;

  /// Display symbol (for example `$`).
  final String? unit;

  /// Serializes this currency.
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
