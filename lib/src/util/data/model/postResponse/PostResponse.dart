
class PostResponse {

  final bool success;
  final List<String> errors;

	PostResponse.fromJsonMap(Map<String, dynamic> map): 
		success = map["success"],
		errors = List<String>.from(map["errors"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['errors'] = errors;
		return data;
	}
}
