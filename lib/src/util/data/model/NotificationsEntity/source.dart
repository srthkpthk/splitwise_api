
class Source {

  final String type;
  final int id;
  final String url;

	Source.fromJsonMap(Map<String, dynamic> map): 
		type = map["type"],
		id = map["id"],
		url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['type'] = type;
		data['id'] = id;
		data['url'] = url;
		return data;
	}
}
