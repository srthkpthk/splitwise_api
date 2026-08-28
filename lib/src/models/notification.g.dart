// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSource _$NotificationSourceFromJson(Map<String, dynamic> json) =>
    NotificationSource(
      type: json['type'] as String?,
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$NotificationSourceToJson(NotificationSource instance) =>
    <String, dynamic>{
      'type': ?instance.type,
      'id': ?instance.id,
      'url': ?instance.url,
    };

SplitwiseNotification _$SplitwiseNotificationFromJson(
  Map<String, dynamic> json,
) => SplitwiseNotification(
  id: (json['id'] as num).toInt(),
  type: (json['type'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  createdBy: (json['created_by'] as num?)?.toInt(),
  source: json['source'] == null
      ? null
      : NotificationSource.fromJson(json['source'] as Map<String, dynamic>),
  imageUrl: json['image_url'] as String?,
  imageShape: $enumDecodeNullable(
    _$ImageShapeEnumMap,
    json['image_shape'],
    unknownValue: ImageShape.unknown,
  ),
  content: json['content'] as String?,
);

Map<String, dynamic> _$SplitwiseNotificationToJson(
  SplitwiseNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': ?instance.type,
  'created_at': ?instance.createdAt?.toUtc().toIso8601String(),
  'created_by': ?instance.createdBy,
  'source': ?instance.source?.toJson(),
  'image_url': ?instance.imageUrl,
  'image_shape': ?_$ImageShapeEnumMap[instance.imageShape],
  'content': ?instance.content,
};

const _$ImageShapeEnumMap = {
  ImageShape.square: 'square',
  ImageShape.circle: 'circle',
  ImageShape.unknown: 'unknown',
};
