class NotificationsEntity {
  List<Notifications> _notifications;

  List<Notifications> get notifications => _notifications;

  NotificationsEntity({
      List<Notifications> notifications}){
    _notifications = notifications;
}

  NotificationsEntity.fromJson(dynamic json) {
    if (json["notifications"] != null) {
      _notifications = [];
      json["notifications"].forEach((v) {
        _notifications.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_notifications != null) {
      map["notifications"] = _notifications.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Notifications {
  int _id;
  int _type;
  String _createdAt;
  int _createdBy;
  Source _source;
  String _imageUrl;
  String _imageShape;
  String _content;

  int get id => _id;
  int get type => _type;
  String get createdAt => _createdAt;
  int get createdBy => _createdBy;
  Source get source => _source;
  String get imageUrl => _imageUrl;
  String get imageShape => _imageShape;
  String get content => _content;

  Notifications({
      int id, 
      int type, 
      String createdAt, 
      int createdBy, 
      Source source, 
      String imageUrl, 
      String imageShape, 
      String content}){
    _id = id;
    _type = type;
    _createdAt = createdAt;
    _createdBy = createdBy;
    _source = source;
    _imageUrl = imageUrl;
    _imageShape = imageShape;
    _content = content;
}

  Notifications.fromJson(dynamic json) {
    _id = json["id"];
    _type = json["type"];
    _createdAt = json["createdAt"];
    _createdBy = json["createdBy"];
    _source = json["source"] != null ? Source.fromJson(json["source"]) : null;
    _imageUrl = json["imageUrl"];
    _imageShape = json["imageShape"];
    _content = json["content"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["type"] = _type;
    map["createdAt"] = _createdAt;
    map["createdBy"] = _createdBy;
    if (_source != null) {
      map["source"] = _source.toJson();
    }
    map["imageUrl"] = _imageUrl;
    map["imageShape"] = _imageShape;
    map["content"] = _content;
    return map;
  }

}

class Source {
  String _type;
  int _id;
  dynamic _url;

  String get type => _type;
  int get id => _id;
  dynamic get url => _url;

  Source({
      String type, 
      int id, 
      dynamic url}){
    _type = type;
    _id = id;
    _url = url;
}

  Source.fromJson(dynamic json) {
    _type = json["type"];
    _id = json["id"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = _type;
    map["id"] = _id;
    map["url"] = _url;
    return map;
  }

}