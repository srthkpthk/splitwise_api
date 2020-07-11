// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsEntity _$NotificationsEntityFromJson(Map<String, dynamic> json) {
  return NotificationsEntity(
    notifications: (json['notifications'] as List)
        ?.map((e) => e == null
            ? null
            : NotificationsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NotificationsEntityToJson(
        NotificationsEntity instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
    };

NotificationsBean _$NotificationsBeanFromJson(Map<String, dynamic> json) {
  return NotificationsBean(
    id: json['id'] as num,
    type: json['type'] as num,
    created_at: json['created_at'] as String,
    created_by: json['created_by'] as num,
    source: json['source'] == null
        ? null
        : NotificationsSourceBean.fromJson(
            json['source'] as Map<String, dynamic>),
    image_url: json['image_url'] as String,
    image_shape: json['image_shape'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$NotificationsBeanToJson(NotificationsBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'created_at': instance.created_at,
      'created_by': instance.created_by,
      'source': instance.source,
      'image_url': instance.image_url,
      'image_shape': instance.image_shape,
      'content': instance.content,
    };

NotificationsSourceBean _$NotificationsSourceBeanFromJson(
    Map<String, dynamic> json) {
  return NotificationsSourceBean(
    type: json['type'] as String,
    id: json['id'] as num,
    url: json['url'],
  );
}

Map<String, dynamic> _$NotificationsSourceBeanToJson(
        NotificationsSourceBean instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'url': instance.url,
    };
