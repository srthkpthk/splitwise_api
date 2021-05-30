
class Receipt {

  final String large;
  final String original;

	Receipt.fromJsonMap(Map<String, dynamic> map): 
		large = map["large"],
		original = map["original"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['large'] = large;
		data['original'] = original;
		return data;
	}
}
