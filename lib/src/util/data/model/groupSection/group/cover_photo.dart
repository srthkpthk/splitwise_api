
class Cover_photo {

  final String xxlarge;
  final String xlarge;

	Cover_photo.fromJsonMap(Map<String, dynamic> map): 
		xxlarge = map["xxlarge"],
		xlarge = map["xlarge"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['xxlarge'] = xxlarge;
		data['xlarge'] = xlarge;
		return data;
	}
}
