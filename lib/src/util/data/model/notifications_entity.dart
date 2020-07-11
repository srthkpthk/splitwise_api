import 'package:json_annotation/json_annotation.dart';

part 'notifications_entity.g.dart';

@JsonSerializable()
class NotificationsEntity {
  List<NotificationsBean> notifications;

  NotificationsEntity({this.notifications});

  factory NotificationsEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsEntityToJson(this);
}

@JsonSerializable()
class NotificationsBean {
  num id;
  num type;
  String created_at;
  num created_by;
  NotificationsSourceBean source;
  String image_url;
  String image_shape;
  String content;

  NotificationsBean(
      {this.id,
      this.type,
      this.created_at,
      this.created_by,
      this.source,
      this.image_url,
      this.image_shape,
      this.content});

  factory NotificationsBean.fromJson(Map<String, dynamic> json) =>
      _$NotificationsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsBeanToJson(this);
}

@JsonSerializable()
class NotificationsSourceBean {
  String type;
  num id;
  dynamic url;

  NotificationsSourceBean({this.type, this.id, this.url});

  factory NotificationsSourceBean.fromJson(Map<String, dynamic> json) =>
      _$NotificationsSourceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsSourceBeanToJson(this);
}
