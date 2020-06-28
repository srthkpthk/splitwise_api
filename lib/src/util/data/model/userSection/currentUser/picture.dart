
class Picture {

  final String small;
  final String medium;
  final String large;

	Picture.fromJsonMap(Map<String, dynamic> map): 
		small = map["small"],
		medium = map["medium"],
		large = map["large"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['small'] = small;
		data['medium'] = medium;
		data['large'] = large;
		return data;
	}
}
