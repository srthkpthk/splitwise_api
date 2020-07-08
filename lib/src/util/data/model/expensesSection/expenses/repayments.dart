
class Repayments {

  final int from;
  final int to;
  final String amount;

	Repayments.fromJsonMap(Map<String, dynamic> map): 
		from = map["from"],
		to = map["to"],
		amount = map["amount"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['from'] = from;
		data['to'] = to;
		data['amount'] = amount;
		return data;
	}
}
