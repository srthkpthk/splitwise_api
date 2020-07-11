// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupEntity _$GroupEntityFromJson(Map<String, dynamic> json) {
  return GroupEntity(
    group: json['group'] == null
        ? null
        : GroupBean.fromJson(json['group'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GroupEntityToJson(GroupEntity instance) =>
    <String, dynamic>{
      'group': instance.group,
    };

GroupBean _$GroupBeanFromJson(Map<String, dynamic> json) {
  return GroupBean(
    id: json['id'] as num,
    name: json['name'] as String,
    created_at: json['created_at'] as String,
    updated_at: json['updated_at'] as String,
    members: (json['members'] as List)
        ?.map((e) => e == null
            ? null
            : GroupMembersBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    simplify_by_default: json['simplify_by_default'] as bool,
    original_debts: (json['original_debts'] as List)
        ?.map((e) => e == null
            ? null
            : GroupOriginal_debtsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    simplified_debts: (json['simplified_debts'] as List)
        ?.map((e) => e == null
            ? null
            : GroupSimplified_debtsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    whiteboard: json['whiteboard'],
    group_type: json['group_type'] as String,
    invite_link: json['invite_link'] as String,
    avatar: json['avatar'] == null
        ? null
        : GroupAvatarBean.fromJson(json['avatar'] as Map<String, dynamic>),
    custom_avatar: json['custom_avatar'] as bool,
    cover_photo: json['cover_photo'] == null
        ? null
        : GroupCover_photoBean.fromJson(
            json['cover_photo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GroupBeanToJson(GroupBean instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'members': instance.members,
      'simplify_by_default': instance.simplify_by_default,
      'original_debts': instance.original_debts,
      'simplified_debts': instance.simplified_debts,
      'whiteboard': instance.whiteboard,
      'group_type': instance.group_type,
      'invite_link': instance.invite_link,
      'avatar': instance.avatar,
      'custom_avatar': instance.custom_avatar,
      'cover_photo': instance.cover_photo,
    };

GroupCover_photoBean _$GroupCover_photoBeanFromJson(Map<String, dynamic> json) {
  return GroupCover_photoBean(
    xxlarge: json['xxlarge'] as String,
    xlarge: json['xlarge'] as String,
  );
}

Map<String, dynamic> _$GroupCover_photoBeanToJson(
        GroupCover_photoBean instance) =>
    <String, dynamic>{
      'xxlarge': instance.xxlarge,
      'xlarge': instance.xlarge,
    };

GroupAvatarBean _$GroupAvatarBeanFromJson(Map<String, dynamic> json) {
  return GroupAvatarBean(
    original: json['original'] as String,
    xxlarge: json['xxlarge'] as String,
    xlarge: json['xlarge'] as String,
    large: json['large'] as String,
    medium: json['medium'] as String,
    small: json['small'] as String,
  );
}

Map<String, dynamic> _$GroupAvatarBeanToJson(GroupAvatarBean instance) =>
    <String, dynamic>{
      'original': instance.original,
      'xxlarge': instance.xxlarge,
      'xlarge': instance.xlarge,
      'large': instance.large,
      'medium': instance.medium,
      'small': instance.small,
    };

GroupSimplified_debtsBean _$GroupSimplified_debtsBeanFromJson(
    Map<String, dynamic> json) {
  return GroupSimplified_debtsBean(
    from: json['from'] as num,
    to: json['to'] as num,
    amount: json['amount'] as String,
    currency_code: json['currency_code'] as String,
  );
}

Map<String, dynamic> _$GroupSimplified_debtsBeanToJson(
        GroupSimplified_debtsBean instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'amount': instance.amount,
      'currency_code': instance.currency_code,
    };

GroupOriginal_debtsBean _$GroupOriginal_debtsBeanFromJson(
    Map<String, dynamic> json) {
  return GroupOriginal_debtsBean(
    to: json['to'] as num,
    from: json['from'] as num,
    amount: json['amount'] as String,
    currency_code: json['currency_code'] as String,
  );
}

Map<String, dynamic> _$GroupOriginal_debtsBeanToJson(
        GroupOriginal_debtsBean instance) =>
    <String, dynamic>{
      'to': instance.to,
      'from': instance.from,
      'amount': instance.amount,
      'currency_code': instance.currency_code,
    };

GroupMembersBean _$GroupMembersBeanFromJson(Map<String, dynamic> json) {
  return GroupMembersBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : GroupPictureBean.fromJson(json['picture'] as Map<String, dynamic>),
    custom_picture: json['custom_picture'] as bool,
    email: json['email'] as String,
    registration_status: json['registration_status'] as String,
    balance: (json['balance'] as List)
        ?.map((e) => e == null
            ? null
            : GroupBalanceBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GroupMembersBeanToJson(GroupMembersBean instance) =>
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

GroupBalanceBean _$GroupBalanceBeanFromJson(Map<String, dynamic> json) {
  return GroupBalanceBean(
    currency_code: json['currency_code'] as String,
    amount: json['amount'] as String,
  );
}

Map<String, dynamic> _$GroupBalanceBeanToJson(GroupBalanceBean instance) =>
    <String, dynamic>{
      'currency_code': instance.currency_code,
      'amount': instance.amount,
    };

GroupPictureBean _$GroupPictureBeanFromJson(Map<String, dynamic> json) {
  return GroupPictureBean(
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$GroupPictureBeanToJson(GroupPictureBean instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };
