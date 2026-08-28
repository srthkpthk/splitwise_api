import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';
import 'image_set.dart';

part 'user.g.dart';

/// A Splitwise user as returned by `get_user`, `update_user` and nested in
/// other objects.
@JsonSerializable()
class User {
  /// Creates a user.
  const User({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.registrationStatus,
    this.picture,
    this.customPicture,
  });

  /// Deserializes a user.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Unique identifier of the user.
  final int id;

  /// The user's first name.
  final String? firstName;

  /// The user's last name.
  final String? lastName;

  /// The user's email address.
  final String? email;

  /// Whether the user has confirmed their account, is a placeholder, or has
  /// only been invited.
  @JsonKey(unknownEnumValue: RegistrationStatus.unknown)
  final RegistrationStatus? registrationStatus;

  /// The user's profile picture.
  final ImageSet? picture;

  /// Whether [picture] was uploaded by the user (as opposed to a default).
  final bool? customPicture;

  /// Serializes this user.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// The authenticated user, as returned by `get_current_user`.
@JsonSerializable()
class CurrentUser extends User {
  /// Creates the current user.
  const CurrentUser({
    required super.id,
    super.firstName,
    super.lastName,
    super.email,
    super.registrationStatus,
    super.picture,
    super.customPicture,
    this.notificationsRead,
    this.notificationsCount,
    this.notifications,
    this.defaultCurrency,
    this.locale,
  });

  /// Deserializes the current user.
  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);

  /// When the user last read their notifications.
  final DateTime? notificationsRead;

  /// Number of unread notifications.
  final int? notificationsCount;

  /// The user's notification preferences, keyed by notification kind
  /// (for example `added_as_friend`).
  final Map<String, bool>? notifications;

  /// ISO 4217 code of the user's default currency.
  final String? defaultCurrency;

  /// The user's locale (for example `en`).
  final String? locale;

  @override
  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}
