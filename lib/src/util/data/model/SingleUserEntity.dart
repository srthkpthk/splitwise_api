class SingleUserEntity {
  SingleUser _user;

  SingleUser get user => _user;

  SingleUserEntity({
      SingleUser user}){
    _user = user;
}

  SingleUserEntity.fromJson(dynamic json) {
    _user = json["user"] != null ? SingleUser.fromJson(json["user"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    return map;
  }

}

class SingleUser {
  int _id;
  String _firstName;
  String _lastName;
  SingleUserPicture _picture;
  bool _customPicture;
  String _email;
  String _registrationStatus;

  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  SingleUserPicture get picture => _picture;
  bool get customPicture => _customPicture;
  String get email => _email;
  String get registrationStatus => _registrationStatus;

  SingleUser({
      int id, 
      String firstName, 
      String lastName, 
      SingleUserPicture picture, 
      bool customPicture, 
      String email, 
      String registrationStatus}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _picture = picture;
    _customPicture = customPicture;
    _email = email;
    _registrationStatus = registrationStatus;
}

  SingleUser.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _picture = json["picture"] != null ? SingleUserPicture.fromJson(json["picture"]) : null;
    _customPicture = json["customPicture"];
    _email = json["email"];
    _registrationStatus = json["registrationStatus"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    if (_picture != null) {
      map["picture"] = _picture.toJson();
    }
    map["customPicture"] = _customPicture;
    map["email"] = _email;
    map["registrationStatus"] = _registrationStatus;
    return map;
  }

}

class SingleUserPicture {
  String _small;
  String _medium;
  String _large;

  String get small => _small;
  String get medium => _medium;
  String get large => _large;

  SingleUserPicture({
      String small, 
      String medium, 
      String large}){
    _small = small;
    _medium = medium;
    _large = large;
}

  SingleUserPicture.fromJson(dynamic json) {
    _small = json["small"];
    _medium = json["medium"];
    _large = json["large"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["small"] = _small;
    map["medium"] = _medium;
    map["large"] = _large;
    return map;
  }

}