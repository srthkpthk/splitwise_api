import 'groups_entity.dart';

class SingleGroupEntity {
  Group _group;

  Group get group => _group;

  SingleGroupEntity({Group group}) {
    _group = group;
  }

  SingleGroupEntity.fromJson(dynamic json) {
    _group = json["group"] != null ? Group.fromJson(json["group"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_group != null) {
      map["group"] = _group.toJson();
    }
    return map;
  }
}

class Group {
  int _id;
  String _name;
  String _createdAt;
  String _updatedAt;
  List<Members> _members;
  bool _simplifyByDefault;
  List<Original_debts> _originalDebts;
  List<Simplified_debts> _simplifiedDebts;
  dynamic _whiteboard;
  String _groupType;
  String _inviteLink;
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

  dynamic get whiteboard => _whiteboard;

  String get groupType => _groupType;

  String get inviteLink => _inviteLink;

  Avatar get avatar => _avatar;

  bool get customAvatar => _customAvatar;

  Cover_photo get coverPhoto => _coverPhoto;

  Group(
      {int id,
      String name,
      String createdAt,
      String updatedAt,
      List<Members> members,
      bool simplifyByDefault,
      List<Original_debts> originalDebts,
      List<Simplified_debts> simplifiedDebts,
      dynamic whiteboard,
      String groupType,
      String inviteLink,
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
    _whiteboard = whiteboard;
    _groupType = groupType;
    _inviteLink = inviteLink;
    _avatar = avatar;
    _customAvatar = customAvatar;
    _coverPhoto = coverPhoto;
  }

  Group.fromJson(dynamic json) {
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
    _whiteboard = json["whiteboard"];
    _groupType = json["groupType"];
    _inviteLink = json["inviteLink"];
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
    map["whiteboard"] = _whiteboard;
    map["groupType"] = _groupType;
    map["inviteLink"] = _inviteLink;
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
