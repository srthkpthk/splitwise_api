class FriendEntity {
  Friend _friend;

  Friend get friend => _friend;

  FriendEntity({Friend friend}) {
    _friend = friend;
  }

  FriendEntity.fromJson(dynamic json) {
    _friend = json["friend"] != null ? Friend.fromJson(json["friend"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_friend != null) {
      map["friend"] = _friend.toJson();
    }
    return map;
  }
}

class Friend {
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

  Friend(
      {int id,
      String firstName,
      dynamic lastName,
      String email,
      String registrationStatus,
      Picture picture,
      List<Balance> balance,
      List<GroupsIn> groups,
      String updatedAt}) {
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

  Friend.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _email = json["email"];
    _registrationStatus = json["registrationStatus"];
    _picture =
        json["picture"] != null ? Picture.fromJson(json["picture"]) : null;
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

class GroupsIn {
  int _groupId;
  List<Balance> _balance;

  int get groupId => _groupId;

  List<Balance> get balance => _balance;

  GroupsIn({int groupId, List<Balance> balance}) {
    _groupId = groupId;
    _balance = balance;
  }

  GroupsIn.fromJson(dynamic json) {
    _groupId = json["groupId"];
    if (json["balance"] != null) {
      _balance = [];
      json["balance"].forEach((v) {
        _balance.add(Balance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["groupId"] = _groupId;
    if (_balance != null) {
      map["balance"] = _balance.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Balance {
  String _currencyCode;
  String _amount;

  String get currencyCode => _currencyCode;

  String get amount => _amount;

  Balance({String currencyCode, String amount}) {
    _currencyCode = currencyCode;
    _amount = amount;
  }

  Balance.fromJson(dynamic json) {
    _currencyCode = json["currencyCode"];
    _amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["currencyCode"] = _currencyCode;
    map["amount"] = _amount;
    return map;
  }
}

class Picture {
  String _small;
  String _medium;
  String _large;

  String get small => _small;

  String get medium => _medium;

  String get large => _large;

  Picture({String small, String medium, String large}) {
    _small = small;
    _medium = medium;
    _large = large;
  }

  Picture.fromJson(dynamic json) {
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
