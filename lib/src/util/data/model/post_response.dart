class PostResponse {
  bool _success;
  List<String> _errors;

  bool get success => _success;
  List<String> get errors => _errors;

  PostResponse({
      bool success, 
      List<String> errors}){
    _success = success;
    _errors = errors;
}

  PostResponse.fromJson(dynamic json) {
    _success = json["success"];
    _errors = json["errors"] != null ? json["errors"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["errors"] = _errors;
    return map;
  }

}