
class Slim {

  final String small;
  final String large;

	Slim.fromJsonMap(Map<String, dynamic> map): 
		small = map["small"],
		large = map["large"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = small;
		data['large'] = large;
		return data;
	}
}
