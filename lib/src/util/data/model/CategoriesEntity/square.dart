
class Square {

  final String large;
  final String xlarge;

	Square.fromJsonMap(Map<String, dynamic> map): 
		large = map["large"],
		xlarge = map["xlarge"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['large'] = large;
		data['xlarge'] = xlarge;
		return data;
	}
}
