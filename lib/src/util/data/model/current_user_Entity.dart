import 'package:json_annotation/json_annotation.dart';

part 'current_user_Entity.g.dart';

@JsonSerializable()
class CurrentUserEntity {
  CurrentUserBean user;

  CurrentUserEntity({this.user});

  factory CurrentUserEntity.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserEntityToJson(this);
}

@JsonSerializable()
class CurrentUserBean {
  num id;
  String first_name;
  String last_name;
  CurrentUserPictureBean picture;
  bool custom_picture;
  String email;
  String registration_status;
  dynamic force_refresh_at;
  String locale;
  String country_code;
  String date_format;
  String default_currency;
  num default_group_id;
  String notifications_read;
  num notifications_count;
  CurrentUserNotificationsBean notifications;

  CurrentUserBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.picture,
      this.custom_picture,
      this.email,
      this.registration_status,
      this.force_refresh_at,
      this.locale,
      this.country_code,
      this.date_format,
      this.default_currency,
      this.default_group_id,
      this.notifications_read,
      this.notifications_count,
      this.notifications});

  factory CurrentUserBean.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserBeanToJson(this);
}

@JsonSerializable()
class CurrentUserNotificationsBean {
  bool added_as_friend;
  bool added_to_group;
  bool expense_added;
  bool expense_updated;
  bool bills;
  bool payments;
  bool monthly_summary;
  bool announcements;

  CurrentUserNotificationsBean(
      {this.added_as_friend,
      this.added_to_group,
      this.expense_added,
      this.expense_updated,
      this.bills,
      this.payments,
      this.monthly_summary,
      this.announcements});

  factory CurrentUserNotificationsBean.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserNotificationsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserNotificationsBeanToJson(this);
}

@JsonSerializable()
class CurrentUserPictureBean {
  String small;
  String medium;
  String large;

  CurrentUserPictureBean({this.small, this.medium, this.large});

  factory CurrentUserPictureBean.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserPictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserPictureBeanToJson(this);
}
