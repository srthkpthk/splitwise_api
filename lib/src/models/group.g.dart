// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupMember _$GroupMemberFromJson(Map<String, dynamic> json) => GroupMember(
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
  balance:
      (json['balance'] as List<dynamic>?)
          ?.map((e) => Balance.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$GroupMemberToJson(GroupMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': ?instance.firstName,
      'last_name': ?instance.lastName,
      'email': ?instance.email,
      'registration_status':
          ?_$RegistrationStatusEnumMap[instance.registrationStatus],
      'picture': ?instance.picture?.toJson(),
      'custom_picture': ?instance.customPicture,
      'balance': instance.balance.map((e) => e.toJson()).toList(),
    };

const _$RegistrationStatusEnumMap = {
  RegistrationStatus.confirmed: 'confirmed',
  RegistrationStatus.dummy: 'dummy',
  RegistrationStatus.invited: 'invited',
  RegistrationStatus.unknown: 'unknown',
};

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  groupType: $enumDecodeNullable(
    _$GroupTypeEnumMap,
    json['group_type'],
    unknownValue: GroupType.unknown,
  ),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  simplifyByDefault: json['simplify_by_default'] as bool?,
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => GroupMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  originalDebts:
      (json['original_debts'] as List<dynamic>?)
          ?.map((e) => Debt.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  simplifiedDebts:
      (json['simplified_debts'] as List<dynamic>?)
          ?.map((e) => Debt.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  avatar: json['avatar'] == null
      ? null
      : ImageSet.fromJson(json['avatar'] as Map<String, dynamic>),
  customAvatar: json['custom_avatar'] as bool?,
  coverPhoto: json['cover_photo'] == null
      ? null
      : ImageSet.fromJson(json['cover_photo'] as Map<String, dynamic>),
  inviteLink: json['invite_link'] as String?,
);

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
  'id': instance.id,
  'name': ?instance.name,
  'group_type': ?_$GroupTypeEnumMap[instance.groupType],
  'updated_at': ?instance.updatedAt?.toUtc().toIso8601String(),
  'simplify_by_default': ?instance.simplifyByDefault,
  'members': instance.members.map((e) => e.toJson()).toList(),
  'original_debts': instance.originalDebts.map((e) => e.toJson()).toList(),
  'simplified_debts': instance.simplifiedDebts.map((e) => e.toJson()).toList(),
  'avatar': ?instance.avatar?.toJson(),
  'custom_avatar': ?instance.customAvatar,
  'cover_photo': ?instance.coverPhoto?.toJson(),
  'invite_link': ?instance.inviteLink,
};

const _$GroupTypeEnumMap = {
  GroupType.home: 'home',
  GroupType.trip: 'trip',
  GroupType.couple: 'couple',
  GroupType.other: 'other',
  GroupType.apartment: 'apartment',
  GroupType.house: 'house',
  GroupType.unknown: 'unknown',
};
