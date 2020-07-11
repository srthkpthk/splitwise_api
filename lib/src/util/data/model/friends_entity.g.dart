// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendsEntity _$FriendsEntityFromJson(Map<String, dynamic> json) {
  return FriendsEntity(
    friends: (json['friends'] as List)
        ?.map((e) =>
            e == null ? null : FriendsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FriendsEntityToJson(FriendsEntity instance) =>
    <String, dynamic>{
      'friends': instance.friends,
    };

FriendsBean _$FriendsBeanFromJson(Map<String, dynamic> json) {
  return FriendsBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'],
    email: json['email'] as String,
    registration_status: json['registration_status'] as String,
    picture: json['picture'] == null
        ? null
        : FriendsPictureBean.fromJson(json['picture'] as Map<String, dynamic>),
    balance: (json['balance'] as List)
        ?.map((e) => e == null
            ? null
            : FriendsBalanceBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    groups: (json['groups'] as List)
        ?.map((e) => e == null
            ? null
            : FriendsGroupsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    updated_at: json['updated_at'] as String,
  );
}

Map<String, dynamic> _$FriendsBeanToJson(FriendsBean instance) =>
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

FriendsGroupsBean _$FriendsGroupsBeanFromJson(Map<String, dynamic> json) {
  return FriendsGroupsBean(
    group_id: json['group_id'] as num,
    balance: (json['balance'] as List)
        ?.map((e) => e == null
            ? null
            : FriendsBalanceBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FriendsGroupsBeanToJson(FriendsGroupsBean instance) =>
    <String, dynamic>{
      'group_id': instance.group_id,
      'balance': instance.balance,
    };

FriendsBalanceBean _$FriendsBalanceBeanFromJson(Map<String, dynamic> json) {
  return FriendsBalanceBean(
    currency_code: json['currency_code'] as String,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$FriendsBalanceBeanToJson(FriendsBalanceBean instance) =>
    <String, dynamic>{
      'currency_code': instance.currency_code,
      'amount': instance.amount,
    };

FriendsPictureBean _$FriendsPictureBeanFromJson(Map<String, dynamic> json) {
  return FriendsPictureBean(
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$FriendsPictureBeanToJson(FriendsPictureBean instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };
