
class Simplified_debts {

  final int to;
  final int from;
  final String amount;
  final String currency_code;

	Simplified_debts.fromJsonMap(Map<String, dynamic> map): 
		to = map["to"],
		from = map["from"],
		amount = map["amount"],
		currency_code = map["currency_code"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['to'] = to;
		data['from'] = from;
		data['amount'] = amount;
		data['currency_code'] = currency_code;
		return data;
	}
}
