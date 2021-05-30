class Errors {
  final String error;

  Errors.fromJsonMap(Map<String, dynamic> map) : error = map["error"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["error"] = error;
    return data;
  }
}
