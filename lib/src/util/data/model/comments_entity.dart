import '../../../../splitwise_api.dart';

class CommentsEntity {
  List<Comments> _comments;

  List<Comments> get comments => _comments;

  CommentsEntity({
      List<Comments> comments}){
    _comments = comments;
}

  CommentsEntity.fromJson(dynamic json) {
    if (json["comments"] != null) {
      _comments = [];
      json["comments"].forEach((v) {
        _comments.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_comments != null) {
      map["comments"] = _comments.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Comments {
  int _id;
  String _content;
  String _commentType;
  String _relationType;
  int _relationId;
  String _createdAt;
  dynamic _deletedAt;
  CommentsUser _user;

  int get id => _id;
  String get content => _content;
  String get commentType => _commentType;
  String get relationType => _relationType;
  int get relationId => _relationId;
  String get createdAt => _createdAt;
  dynamic get deletedAt => _deletedAt;
  CommentsUser get user => _user;

  Comments({
      int id, 
      String content, 
      String commentType, 
      String relationType, 
      int relationId, 
      String createdAt, 
      dynamic deletedAt, 
      CommentsUser user}){
    _id = id;
    _content = content;
    _commentType = commentType;
    _relationType = relationType;
    _relationId = relationId;
    _createdAt = createdAt;
    _deletedAt = deletedAt;
    _user = user;
}

  Comments.fromJson(dynamic json) {
    _id = json["id"];
    _content = json["content"];
    _commentType = json["commentType"];
    _relationType = json["relationType"];
    _relationId = json["relationId"];
    _createdAt = json["createdAt"];
    _deletedAt = json["deletedAt"];
    _user = json["user"] != null ? CommentsUser.fromJson(json["user"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["content"] = _content;
    map["commentType"] = _commentType;
    map["relationType"] = _relationType;
    map["relationId"] = _relationId;
    map["createdAt"] = _createdAt;
    map["deletedAt"] = _deletedAt;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    return map;
  }

}

class CommentsUser {
  int _id;
  String _firstName;
  String _lastName;
  Picture _picture;

  int get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  Picture get picture => _picture;

  CommentsUser({
      int id, 
      String firstName, 
      String lastName, 
      Picture picture}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _picture = picture;
}

  CommentsUser.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _picture = json["picture"] != null ? Picture.fromJson(json["picture"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    if (_picture != null) {
      map["picture"] = _picture.toJson();
    }
    return map;
  }

}

