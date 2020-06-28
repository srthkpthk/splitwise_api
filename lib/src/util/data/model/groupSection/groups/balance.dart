
class Balance {

  final String amount;
  final String currency_code;

	Balance.fromJsonMap(Map<String, dynamic> map): 
		amount = map["amount"],
		currency_code = map["currency_code"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['amount'] = amount;
		data['currency_code'] = currency_code;
		return data;
	}
}
