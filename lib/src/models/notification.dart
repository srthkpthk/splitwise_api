import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';

part 'notification.g.dart';

/// The object that triggered a notification.
@JsonSerializable()
class NotificationSource {
  /// Creates a notification source.
  const NotificationSource({this.type, this.id, this.url});

  /// Deserializes a notification source.
  factory NotificationSource.fromJson(Map<String, dynamic> json) =>
      _$NotificationSourceFromJson(json);

  /// Kind of object (for example `Expense`).
  final String? type;

  /// ID of the object.
  final int? id;

  /// Link to the object, when available.
  final String? url;

  /// Serializes this notification source.
  Map<String, dynamic> toJson() => _$NotificationSourceToJson(this);
}

/// A notification shown to the current user.
///
/// Named `SplitwiseNotification` to avoid clashing with Flutter's
/// `Notification` widget class.
@JsonSerializable()
class SplitwiseNotification {
  /// Creates a notification.
  const SplitwiseNotification({
    required this.id,
    this.type,
    this.createdAt,
    this.createdBy,
    this.source,
    this.imageUrl,
    this.imageShape,
    this.content,
  });

  /// Deserializes a notification.
  factory SplitwiseNotification.fromJson(Map<String, dynamic> json) =>
      _$SplitwiseNotificationFromJson(json);

  /// Unique identifier of the notification.
  final int id;

  /// Numeric notification type as defined by Splitwise.
  final int? type;

  /// When the notification was created.
  final DateTime? createdAt;

  /// ID of the user whose action produced the notification.
  final int? createdBy;

  /// The object that triggered the notification.
  final NotificationSource? source;

  /// URL of the image shown next to the notification.
  final String? imageUrl;

  /// Shape in which [imageUrl] should be rendered.
  @JsonKey(unknownEnumValue: ImageShape.unknown)
  final ImageShape? imageShape;

  /// HTML content of the notification.
  final String? content;

  /// Serializes this notification.
  Map<String, dynamic> toJson() => _$SplitwiseNotificationToJson(this);
}
