// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendGroupBalance _$FriendGroupBalanceFromJson(Map<String, dynamic> json) =>
    FriendGroupBalance(
      groupId: (json['group_id'] as num?)?.toInt(),
      balance:
          (json['balance'] as List<dynamic>?)
              ?.map((e) => Balance.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FriendGroupBalanceToJson(FriendGroupBalance instance) =>
    <String, dynamic>{
      'group_id': ?instance.groupId,
      'balance': instance.balance.map((e) => e.toJson()).toList(),
    };

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend(
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
  groups:
      (json['groups'] as List<dynamic>?)
          ?.map((e) => FriendGroupBalance.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  balance:
      (json['balance'] as List<dynamic>?)
          ?.map((e) => Balance.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'email': ?instance.email,
  'registration_status':
      ?_$RegistrationStatusEnumMap[instance.registrationStatus],
  'picture': ?instance.picture?.toJson(),
  'custom_picture': ?instance.customPicture,
  'groups': instance.groups.map((e) => e.toJson()).toList(),
  'balance': instance.balance.map((e) => e.toJson()).toList(),
  'updated_at': ?instance.updatedAt?.toUtc().toIso8601String(),
};

const _$RegistrationStatusEnumMap = {
  RegistrationStatus.confirmed: 'confirmed',
  RegistrationStatus.dummy: 'dummy',
  RegistrationStatus.invited: 'invited',
  RegistrationStatus.unknown: 'unknown',
};
