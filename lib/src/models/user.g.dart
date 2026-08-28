// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  registrationStatus: $enumDecodeNullable(
    _$RegistrationStatusEnumMap,
    json['registration_status'],
    unknownValue: RegistrationStatus.unknown,
  ),
  picture: json['picture'] == null
      ? null
      : ImageSet.fromJson(json['picture'] as Map<String, dynamic>),
  customPicture: json['custom_picture'] as bool?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'email': ?instance.email,
  'registration_status':
      ?_$RegistrationStatusEnumMap[instance.registrationStatus],
  'picture': ?instance.picture?.toJson(),
  'custom_picture': ?instance.customPicture,
};

const _$RegistrationStatusEnumMap = {
  RegistrationStatus.confirmed: 'confirmed',
  RegistrationStatus.dummy: 'dummy',
  RegistrationStatus.invited: 'invited',
  RegistrationStatus.unknown: 'unknown',
};

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) => CurrentUser(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  email: json['email'] as String?,
  registrationStatus: $enumDecodeNullable(
    _$RegistrationStatusEnumMap,
    json['registration_status'],
    unknownValue: RegistrationStatus.unknown,
  ),
  picture: json['picture'] == null
      ? null
      : ImageSet.fromJson(json['picture'] as Map<String, dynamic>),
  customPicture: json['custom_picture'] as bool?,
  notificationsRead: json['notifications_read'] == null
      ? null
      : DateTime.parse(json['notifications_read'] as String),
  notificationsCount: (json['notifications_count'] as num?)?.toInt(),
  notifications: (json['notifications'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as bool),
  ),
  defaultCurrency: json['default_currency'] as String?,
  locale: json['locale'] as String?,
);

Map<String, dynamic> _$CurrentUserToJson(
  CurrentUser instance,
) => <String, dynamic>{
  'id': instance.id,
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'email': ?instance.email,
  'registration_status':
      ?_$RegistrationStatusEnumMap[instance.registrationStatus],
  'picture': ?instance.picture?.toJson(),
  'custom_picture': ?instance.customPicture,
  'notifications_read': ?instance.notificationsRead?.toUtc().toIso8601String(),
  'notifications_count': ?instance.notificationsCount,
  'notifications': ?instance.notifications,
  'default_currency': ?instance.defaultCurrency,
  'locale': ?instance.locale,
};
