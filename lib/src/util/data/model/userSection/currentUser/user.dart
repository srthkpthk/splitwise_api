
import 'package:splitwise_api/src/util/data/model/userSection/currentUser/notifications.dart';
import 'package:splitwise_api/src/util/data/model/userSection/currentUser/picture.dart';

class User {

  final int id;
  final String first_name;
  final String last_name;
  final Picture picture;
  final bool custom_picture;
  final String email;
  final String registration_status;
  final Object force_refresh_at;
  final String locale;
  final String country_code;
  final String date_format;
  final String default_currency;
  final int default_group_id;
  final String notifications_read;
  final int notifications_count;
  final Notifications notifications;

	User.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		first_name = map["first_name"],
		last_name = map["last_name"],
		picture = Picture.fromJsonMap(map["picture"]),
		custom_picture = map["custom_picture"],
		email = map["email"],
		registration_status = map["registration_status"],
		force_refresh_at = map["force_refresh_at"],
		locale = map["locale"],
		country_code = map["country_code"],
		date_format = map["date_format"],
		default_currency = map["default_currency"],
		default_group_id = map["default_group_id"],
		notifications_read = map["notifications_read"],
		notifications_count = map["notifications_count"],
		notifications = Notifications.fromJsonMap(map["notifications"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['first_name'] = first_name;
		data['last_name'] = last_name;
		data['picture'] = picture == null ? null : picture.toJson();
		data['custom_picture'] = custom_picture;
		data['email'] = email;
		data['registration_status'] = registration_status;
		data['force_refresh_at'] = force_refresh_at;
		data['locale'] = locale;
		data['country_code'] = country_code;
		data['date_format'] = date_format;
		data['default_currency'] = default_currency;
		data['default_group_id'] = default_group_id;
		data['notifications_read'] = notifications_read;
		data['notifications_count'] = notifications_count;
		data['notifications'] = notifications == null ? null : notifications.toJson();
		return data;
	}
}
