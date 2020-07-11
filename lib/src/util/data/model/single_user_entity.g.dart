// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleUserEntity _$SingleUserEntityFromJson(Map<String, dynamic> json) {
  return SingleUserEntity(
    user: json['user'] == null
        ? null
        : SingleUserBean.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SingleUserEntityToJson(SingleUserEntity instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

SingleUserBean _$SingleUserBeanFromJson(Map<String, dynamic> json) {
  return SingleUserBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : SingleUserPictureBean.fromJson(
            json['picture'] as Map<String, dynamic>),
    custom_picture: json['custom_picture'] as bool,
    email: json['email'] as String,
    registration_status: json['registration_status'] as String,
  );
}

Map<String, dynamic> _$SingleUserBeanToJson(SingleUserBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
      'custom_picture': instance.custom_picture,
      'email': instance.email,
      'registration_status': instance.registration_status,
    };

SingleUserPictureBean _$SingleUserPictureBeanFromJson(
    Map<String, dynamic> json) {
  return SingleUserPictureBean(
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$SingleUserPictureBeanToJson(
        SingleUserPictureBean instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };
