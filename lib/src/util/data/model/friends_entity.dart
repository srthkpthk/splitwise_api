import '../../../../splitwise_api.dart';

class FriendsEntity {
  List<Friends> _friends;

  List<Friends> get friends => _friends;

  FriendsEntity({
      List<Friends> friends}){
    _friends = friends;
}

  FriendsEntity.fromJson(dynamic json) {
    if (json["friends"] != null) {
      _friends = [];
      json["friends"].forEach((v) {
        _friends.add(Friends.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_friends != null) {
      map["friends"] = _friends.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Friends {
  int _id;
  String _firstName;
  dynamic _lastName;
  String _email;
  String _registrationStatus;
  Picture _picture;
  List<Balance> _balance;
  List<GroupsIn> _groups;
  String _updatedAt;

  int get id => _id;
  String get firstName => _firstName;
  dynamic get lastName => _lastName;
  String get email => _email;
  String get registrationStatus => _registrationStatus;
  Picture get picture => _picture;
  List<Balance> get balance => _balance;
  List<GroupsIn> get groups => _groups;
  String get updatedAt => _updatedAt;

  Friends({
      int id, 
      String firstName, 
      dynamic lastName, 
      String email, 
      String registrationStatus, 
      Picture picture, 
      List<Balance> balance, 
      List<GroupsIn> groups, 
      String updatedAt}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _registrationStatus = registrationStatus;
    _picture = picture;
    _balance = balance;
    _groups = groups;
    _updatedAt = updatedAt;
}

  Friends.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _email = json["email"];
    _registrationStatus = json["registrationStatus"];
    _picture = json["picture"] != null ? Picture.fromJson(json["picture"]) : null;
    if (json["balance"] != null) {
      _balance = [];
      json["balance"].forEach((v) {
        _balance.add(Balance.fromJson(v));
      });
    }
    if (json["groups"] != null) {
      _groups = [];
      json["groups"].forEach((v) {
        _groups.add(GroupsIn.fromJson(v));
      });
    }
    _updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["email"] = _email;
    map["registrationStatus"] = _registrationStatus;
    if (_picture != null) {
      map["picture"] = _picture.toJson();
    }
    if (_balance != null) {
      map["balance"] = _balance.map((v) => v.toJson()).toList();
    }
    if (_groups != null) {
      map["groups"] = _groups.map((v) => v.toJson()).toList();
    }
    map["updatedAt"] = _updatedAt;
    return map;
  }

}




