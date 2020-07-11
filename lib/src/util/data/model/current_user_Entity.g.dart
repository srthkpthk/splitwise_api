// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_Entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentUserEntity _$CurrentUserEntityFromJson(Map<String, dynamic> json) {
  return CurrentUserEntity(
    user: json['user'] == null
        ? null
        : CurrentUserBean.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CurrentUserEntityToJson(CurrentUserEntity instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

CurrentUserBean _$CurrentUserBeanFromJson(Map<String, dynamic> json) {
  return CurrentUserBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : CurrentUserPictureBean.fromJson(
            json['picture'] as Map<String, dynamic>),
    custom_picture: json['custom_picture'] as bool,
    email: json['email'] as String,
    registration_status: json['registration_status'] as String,
    force_refresh_at: json['force_refresh_at'],
    locale: json['locale'] as String,
    country_code: json['country_code'] as String,
    date_format: json['date_format'] as String,
    default_currency: json['default_currency'] as String,
    default_group_id: json['default_group_id'] as num,
    notifications_read: json['notifications_read'] as String,
    notifications_count: json['notifications_count'] as num,
    notifications: json['notifications'] == null
        ? null
        : CurrentUserNotificationsBean.fromJson(
            json['notifications'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CurrentUserBeanToJson(CurrentUserBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
      'custom_picture': instance.custom_picture,
      'email': instance.email,
      'registration_status': instance.registration_status,
      'force_refresh_at': instance.force_refresh_at,
      'locale': instance.locale,
      'country_code': instance.country_code,
      'date_format': instance.date_format,
      'default_currency': instance.default_currency,
      'default_group_id': instance.default_group_id,
      'notifications_read': instance.notifications_read,
      'notifications_count': instance.notifications_count,
      'notifications': instance.notifications,
    };

CurrentUserNotificationsBean _$CurrentUserNotificationsBeanFromJson(
    Map<String, dynamic> json) {
  return CurrentUserNotificationsBean(
    added_as_friend: json['added_as_friend'] as bool,
    added_to_group: json['added_to_group'] as bool,
    expense_added: json['expense_added'] as bool,
    expense_updated: json['expense_updated'] as bool,
    bills: json['bills'] as bool,
    payments: json['payments'] as bool,
    monthly_summary: json['monthly_summary'] as bool,
    announcements: json['announcements'] as bool,
  );
}

Map<String, dynamic> _$CurrentUserNotificationsBeanToJson(
        CurrentUserNotificationsBean instance) =>
    <String, dynamic>{
      'added_as_friend': instance.added_as_friend,
      'added_to_group': instance.added_to_group,
      'expense_added': instance.expense_added,
      'expense_updated': instance.expense_updated,
      'bills': instance.bills,
      'payments': instance.payments,
      'monthly_summary': instance.monthly_summary,
      'announcements': instance.announcements,
    };

CurrentUserPictureBean _$CurrentUserPictureBeanFromJson(
    Map<String, dynamic> json) {
  return CurrentUserPictureBean(
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$CurrentUserPictureBeanToJson(
        CurrentUserPictureBean instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };
