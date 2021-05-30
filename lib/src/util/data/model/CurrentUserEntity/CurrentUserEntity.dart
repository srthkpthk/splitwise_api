import 'package:splitwise_api/src/util/data/model/CurrentUserEntity/notifications.dart';
import 'package:splitwise_api/src/util/data/model/SingleUserEntity/picture.dart';

class CurrentUserEntity {
  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String registration_status;
  final Picture picture;
  final String notifications_read;
  final int notifications_count;
  final Notifications notifications;
  final String default_currency;
  final String locale;

  CurrentUserEntity.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        first_name = map["first_name"],
        last_name = map["last_name"],
        email = map["email"],
        registration_status = map["registration_status"],
        picture = Picture.fromJsonMap(map["picture"]),
        notifications_read = map["notifications_read"],
        notifications_count = map["notifications_count"],
        notifications = Notifications.fromJsonMap(map["notifications"]),
        default_currency = map["default_currency"],
        locale = map["locale"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['email'] = email;
    data['registration_status'] = registration_status;
    data['picture'] = picture == null ? null : picture.toJson();
    data['notifications_read'] = notifications_read;
    data['notifications_count'] = notifications_count;
    data['notifications'] =
        notifications == null ? null : notifications.toJson();
    data['default_currency'] = default_currency;
    data['locale'] = locale;
    return data;
  }
}
