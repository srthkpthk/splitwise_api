
class Simplified_debts {

  final int from;
  final int to;
  final String amount;
  final String currency_code;

	Simplified_debts.fromJsonMap(Map<String, dynamic> map): 
		from = map["from"],
		to = map["to"],
		amount = map["amount"],
		currency_code = map["currency_code"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['from'] = from;
		data['to'] = to;
		data['amount'] = amount;
		data['currency_code'] = currency_code;
		return data;
	}
}
