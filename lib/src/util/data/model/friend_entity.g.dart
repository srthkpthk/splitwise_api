// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendEntity _$FriendEntityFromJson(Map<String, dynamic> json) {
  return FriendEntity(
    friend: json['friend'] == null
        ? null
        : FriendBean.fromJson(json['friend'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FriendEntityToJson(FriendEntity instance) =>
    <String, dynamic>{
      'friend': instance.friend,
    };

FriendBean _$FriendBeanFromJson(Map<String, dynamic> json) {
  return FriendBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'],
    email: json['email'] as String,
    registration_status: json['registration_status'] as String,
    picture: json['picture'] == null
        ? null
        : FriendPictureBean.fromJson(json['picture'] as Map<String, dynamic>),
    balance: (json['balance'] as List)
        ?.map((e) => e == null
            ? null
            : FriendBalanceBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    groups: (json['groups'] as List)
        ?.map((e) => e == null
            ? null
            : FriendGroupsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    updated_at: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$FriendBeanToJson(FriendBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'registration_status': instance.registration_status,
      'picture': instance.picture,
      'balance': instance.balance,
      'groups': instance.groups,
      'updated_at': instance.updated_at,
    };

FriendGroupsBean _$FriendGroupsBeanFromJson(Map<String, dynamic> json) {
  return FriendGroupsBean(
    group_id: json['group_id'] as num,
    balance: (json['balance'] as List)
        ?.map((e) => e == null
            ? null
            : FriendBalanceBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FriendGroupsBeanToJson(FriendGroupsBean instance) =>
    <String, dynamic>{
      'group_id': instance.group_id,
      'balance': instance.balance,
    };

FriendBalanceBean _$FriendBalanceBeanFromJson(Map<String, dynamic> json) {
  return FriendBalanceBean(
    currency_code: json['currency_code'] as String,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$FriendBalanceBeanToJson(FriendBalanceBean instance) =>
    <String, dynamic>{
      'currency_code': instance.currency_code,
      'amount': instance.amount,
    };

FriendPictureBean _$FriendPictureBeanFromJson(Map<String, dynamic> json) {
  return FriendPictureBean(
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$FriendPictureBeanToJson(FriendPictureBean instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };
