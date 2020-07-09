import '../../../../splitwise_api.dart';

class GroupsEntity {
  List<Groups> _groups;

  List<Groups> get groups => _groups;

  GroupsEntity({List<Groups> groups}) {
    _groups = groups;
  }

  GroupsEntity.fromJson(dynamic json) {
    if (json["groups"] != null) {
      _groups = [];
      json["groups"].forEach((v) {
        _groups.add(Groups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_groups != null) {
      map["groups"] = _groups.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Groups {
  int _id;
  String _name;
  String _createdAt;
  String _updatedAt;
  List<Members> _members;
  bool _simplifyByDefault;
  List<Original_debts> _originalDebts;
  List<Simplified_debts> _simplifiedDebts;
  Avatar _avatar;
  bool _customAvatar;
  Cover_photo _coverPhoto;

  int get id => _id;

  String get name => _name;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  List<Members> get members => _members;

  bool get simplifyByDefault => _simplifyByDefault;

  List<Original_debts> get originalDebts => _originalDebts;

  List<Simplified_debts> get simplifiedDebts => _simplifiedDebts;

  Avatar get avatar => _avatar;

  bool get customAvatar => _customAvatar;

  Cover_photo get coverPhoto => _coverPhoto;

  Groups(
      {int id,
      String name,
      String createdAt,
      String updatedAt,
      List<Members> members,
      bool simplifyByDefault,
      List<Original_debts> originalDebts,
      List<Simplified_debts> simplifiedDebts,
      Avatar avatar,
      bool customAvatar,
      Cover_photo coverPhoto}) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _members = members;
    _simplifyByDefault = simplifyByDefault;
    _originalDebts = originalDebts;
    _simplifiedDebts = simplifiedDebts;
    _avatar = avatar;
    _customAvatar = customAvatar;
    _coverPhoto = coverPhoto;
  }

  Groups.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    if (json["members"] != null) {
      _members = [];
      json["members"].forEach((v) {
        _members.add(Members.fromJson(v));
      });
    }
    _simplifyByDefault = json["simplifyByDefault"];
    if (json["originalDebts"] != null) {
      _originalDebts = [];
      json["originalDebts"].forEach((v) {
        _originalDebts.add(Original_debts.fromJson(v));
      });
    }
    if (json["simplifiedDebts"] != null) {
      _simplifiedDebts = [];
      json["simplifiedDebts"].forEach((v) {
        _simplifiedDebts.add(Simplified_debts.fromJson(v));
      });
    }
    _avatar = json["avatar"] != null ? Avatar.fromJson(json["avatar"]) : null;
    _customAvatar = json["customAvatar"];
    _coverPhoto = json["coverPhoto"] != null
        ? Cover_photo.fromJson(json["coverPhoto"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    if (_members != null) {
      map["members"] = _members.map((v) => v.toJson()).toList();
    }
    map["simplifyByDefault"] = _simplifyByDefault;
    if (_originalDebts != null) {
      map["originalDebts"] = _originalDebts.map((v) => v.toJson()).toList();
    }
    if (_simplifiedDebts != null) {
      map["simplifiedDebts"] = _simplifiedDebts.map((v) => v.toJson()).toList();
    }
    if (_avatar != null) {
      map["avatar"] = _avatar.toJson();
    }
    map["customAvatar"] = _customAvatar;
    if (_coverPhoto != null) {
      map["coverPhoto"] = _coverPhoto.toJson();
    }
    return map;
  }
}

class Cover_photo {
  String _xxlarge;
  String _xlarge;

  String get xxlarge => _xxlarge;

  String get xlarge => _xlarge;

  Cover_photo({String xxlarge, String xlarge}) {
    _xxlarge = xxlarge;
    _xlarge = xlarge;
  }

  Cover_photo.fromJson(dynamic json) {
    _xxlarge = json["xxlarge"];
    _xlarge = json["xlarge"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["xxlarge"] = _xxlarge;
    map["xlarge"] = _xlarge;
    return map;
  }
}

class Avatar {
  dynamic _original;
  String _xxlarge;
  String _xlarge;
  String _large;
  String _medium;
  String _small;

  dynamic get original => _original;

  String get xxlarge => _xxlarge;

  String get xlarge => _xlarge;

  String get large => _large;

  String get medium => _medium;

  String get small => _small;

  Avatar(
      {dynamic original,
      String xxlarge,
      String xlarge,
      String large,
      String medium,
      String small}) {
    _original = original;
    _xxlarge = xxlarge;
    _xlarge = xlarge;
    _large = large;
    _medium = medium;
    _small = small;
  }

  Avatar.fromJson(dynamic json) {
    _original = json["original"];
    _xxlarge = json["xxlarge"];
    _xlarge = json["xlarge"];
    _large = json["large"];
    _medium = json["medium"];
    _small = json["small"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["original"] = _original;
    map["xxlarge"] = _xxlarge;
    map["xlarge"] = _xlarge;
    map["large"] = _large;
    map["medium"] = _medium;
    map["small"] = _small;
    return map;
  }
}

class Simplified_debts {
  String _currencyCode;
  int _from;
  int _to;
  String _amount;

  String get currencyCode => _currencyCode;

  int get from => _from;

  int get to => _to;

  String get amount => _amount;

  Simplified_debts({String currencyCode, int from, int to, String amount}) {
    _currencyCode = currencyCode;
    _from = from;
    _to = to;
    _amount = amount;
  }

  Simplified_debts.fromJson(dynamic json) {
    _currencyCode = json["currencyCode"];
    _from = json["from"];
    _to = json["to"];
    _amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["currencyCode"] = _currencyCode;
    map["from"] = _from;
    map["to"] = _to;
    map["amount"] = _amount;
    return map;
  }
}

class Original_debts {
  String _currencyCode;
  int _from;
  int _to;
  String _amount;

  String get currencyCode => _currencyCode;

  int get from => _from;

  int get to => _to;

  String get amount => _amount;

  Original_debts({String currencyCode, int from, int to, String amount}) {
    _currencyCode = currencyCode;
    _from = from;
    _to = to;
    _amount = amount;
  }

  Original_debts.fromJson(dynamic json) {
    _currencyCode = json["currencyCode"];
    _from = json["from"];
    _to = json["to"];
    _amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["currencyCode"] = _currencyCode;
    map["from"] = _from;
    map["to"] = _to;
    map["amount"] = _amount;
    return map;
  }
}

class Members {
  int _id;
  String _firstName;
  String _lastName;
  Picture _picture;
  bool _customPicture;
  String _email;
  String _registrationStatus;
  List<Balance> _balance;

  int get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  Picture get picture => _picture;

  bool get customPicture => _customPicture;

  String get email => _email;

  String get registrationStatus => _registrationStatus;

  List<Balance> get balance => _balance;

  Members(
      {int id,
      String firstName,
      String lastName,
      Picture picture,
      bool customPicture,
      String email,
      String registrationStatus,
      List<Balance> balance}) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _picture = picture;
    _customPicture = customPicture;
    _email = email;
    _registrationStatus = registrationStatus;
    _balance = balance;
  }

  Members.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _picture =
        json["picture"] != null ? Picture.fromJson(json["picture"]) : null;
    _customPicture = json["customPicture"];
    _email = json["email"];
    _registrationStatus = json["registrationStatus"];
    if (json["balance"] != null) {
      _balance = [];
      json["balance"].forEach((v) {
        _balance.add(Balance.fromJson(v));
      });
    }
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
    if (_balance != null) {
      map["balance"] = _balance.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
