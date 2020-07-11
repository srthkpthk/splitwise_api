// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groups_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupsEntity _$GroupsEntityFromJson(Map<String, dynamic> json) {
  return GroupsEntity(
    groups: (json['groups'] as List)
        ?.map((e) =>
            e == null ? null : GroupsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GroupsEntityToJson(GroupsEntity instance) =>
    <String, dynamic>{
      'groups': instance.groups,
    };

GroupsBean _$GroupsBeanFromJson(Map<String, dynamic> json) {
  return GroupsBean(
    id: json['id'] as num,
    name: json['name'] as String,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
    members: (json['members'] as List)
        ?.map((e) => e == null
            ? null
            : GroupsMembersBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    simplify_by_default: json['simplify_by_default'] as bool,
    original_debts: (json['original_debts'] as List)
        ?.map((e) => e == null
            ? null
            : GroupsOriginal_debtsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    simplified_debts: (json['simplified_debts'] as List)
        ?.map((e) => e == null
            ? null
            : GroupsSimplified_debtsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    avatar: json['avatar'] == null
        ? null
        : GroupsAvatarBean.fromJson(json['avatar'] as Map<String, dynamic>),
    custom_avatar: json['custom_avatar'] as bool,
    cover_photo: json['cover_photo'] == null
        ? null
        : GroupsCover_photoBean.fromJson(
            json['cover_photo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GroupsBeanToJson(GroupsBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'members': instance.members,
      'simplify_by_default': instance.simplify_by_default,
      'original_debts': instance.original_debts,
      'simplified_debts': instance.simplified_debts,
      'avatar': instance.avatar,
      'custom_avatar': instance.custom_avatar,
      'cover_photo': instance.cover_photo,
    };

GroupsCover_photoBean _$GroupsCover_photoBeanFromJson(
    Map<String, dynamic> json) {
  return GroupsCover_photoBean(
    xxlarge: json['xxlarge'] as String,
    xlarge: json['xlarge'] as String,
  );
}

Map<String, dynamic> _$GroupsCover_photoBeanToJson(
        GroupsCover_photoBean instance) =>
    <String, dynamic>{
      'xxlarge': instance.xxlarge,
      'xlarge': instance.xlarge,
    };

GroupsAvatarBean _$GroupsAvatarBeanFromJson(Map<String, dynamic> json) {
  return GroupsAvatarBean(
    original: json['original'],
    xxlarge: json['xxlarge'] as String,
    xlarge: json['xlarge'] as String,
    large: json['large'] as String,
    medium: json['medium'] as String,
    small: json['small'] as String,
  );
}

Map<String, dynamic> _$GroupsAvatarBeanToJson(GroupsAvatarBean instance) =>
    <String, dynamic>{
      'original': instance.original,
      'xxlarge': instance.xxlarge,
      'xlarge': instance.xlarge,
      'large': instance.large,
      'medium': instance.medium,
      'small': instance.small,
    };

GroupsSimplified_debtsBean _$GroupsSimplified_debtsBeanFromJson(
    Map<String, dynamic> json) {
  return GroupsSimplified_debtsBean(
    currency_code: json['currency_code'] as String,
    from: json['from'] as num,
    to: json['to'] as num,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$GroupsSimplified_debtsBeanToJson(
        GroupsSimplified_debtsBean instance) =>
    <String, dynamic>{
      'currency_code': instance.currency_code,
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
    };

GroupsOriginal_debtsBean _$GroupsOriginal_debtsBeanFromJson(
    Map<String, dynamic> json) {
  return GroupsOriginal_debtsBean(
    currency_code: json['currency_code'] as String,
    from: json['from'] as num,
    to: json['to'] as num,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$GroupsOriginal_debtsBeanToJson(
        GroupsOriginal_debtsBean instance) =>
    <String, dynamic>{
      'currency_code': instance.currency_code,
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
    };

GroupsMembersBean _$GroupsMembersBeanFromJson(Map<String, dynamic> json) {
  return GroupsMembersBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : GroupsPictureBean.fromJson(json['picture'] as Map<String, dynamic>),
    custom_picture: json['custom_picture'] as bool,
    email: json['email'] as String,
    registration_status: json['registration_status'] as String,
    balance: (json['balance'] as List)
        ?.map((e) => e == null
            ? null
            : GroupsBalanceBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GroupsMembersBeanToJson(GroupsMembersBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
      'custom_picture': instance.custom_picture,
      'email': instance.email,
      'registration_status': instance.registration_status,
      'balance': instance.balance,
    };

GroupsBalanceBean _$GroupsBalanceBeanFromJson(Map<String, dynamic> json) {
  return GroupsBalanceBean(
    amount: json['amount'] as String,
    currency_code: json['currency_code'] as String,
  );
}

Map<String, dynamic> _$GroupsBalanceBeanToJson(GroupsBalanceBean instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency_code': instance.currency_code,
    };

GroupsPictureBean _$GroupsPictureBeanFromJson(Map<String, dynamic> json) {
  return GroupsPictureBean(
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$GroupsPictureBeanToJson(GroupsPictureBean instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };
