import 'package:splitwise_api/generated/json/base/json_convert_content.dart';
import 'package:splitwise_api/generated/json/base/json_filed.dart';

class CurrentUserEntity with JsonConvert<CurrentUserEntity> {
  CurrentUserUser user;
}

class CurrentUserUser with JsonConvert<CurrentUserUser> {
  int id;
  @JSONField(name: "first_name")
  String firstName;
  @JSONField(name: "last_name")
  String lastName;
  CurrentUserUserPicture picture;
  @JSONField(name: "custom_picture")
  bool customPicture;
  String email;
  @JSONField(name: "registration_status")
  String registrationStatus;
  @JSONField(name: "force_refresh_at")
  dynamic forceRefreshAt;
  String locale;
  @JSONField(name: "country_code")
  String countryCode;
  @JSONField(name: "date_format")
  String dateFormat;
  @JSONField(name: "default_currency")
  String defaultCurrency;
  @JSONField(name: "default_group_id")
  int defaultGroupId;
  @JSONField(name: "notifications_read")
  String notificationsRead;
  @JSONField(name: "notifications_count")
  int notificationsCount;
  CurrentUserUserNotifications notifications;
}

class CurrentUserUserPicture with JsonConvert<CurrentUserUserPicture> {
  String small;
  String medium;
  String large;
}

class CurrentUserUserNotifications with JsonConvert<CurrentUserUserNotifications> {
  @JSONField(name: "added_as_friend")
  bool addedAsFriend;
  @JSONField(name: "added_to_group")
  bool addedToGroup;
  @JSONField(name: "expense_added")
  bool expenseAdded;
  @JSONField(name: "expense_updated")
  bool expenseUpdated;
  bool bills;
  bool payments;
  @JSONField(name: "monthly_summary")
  bool monthlySummary;
  bool announcements;
}
