
class Avatar {

  final Object original;
  final String xxlarge;
  final String xlarge;
  final String large;
  final String medium;
  final String small;

	Avatar.fromJsonMap(Map<String, dynamic> map): 
		original = map["original"],
		xxlarge = map["xxlarge"],
		xlarge = map["xlarge"],
		large = map["large"],
		medium = map["medium"],
		small = map["small"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['original'] = original;
		data['xxlarge'] = xxlarge;
		data['xlarge'] = xlarge;
		data['large'] = large;
		data['medium'] = medium;
		data['small'] = small;
		return data;
	}
}
