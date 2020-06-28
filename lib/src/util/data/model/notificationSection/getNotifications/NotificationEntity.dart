import 'package:splitwise_api/src/util/data/model/notificationSection/getNotifications/notifications.dart';

class NotificationEntity {

  final List<Notifications> notifications;

	NotificationEntity.fromJsonMap(Map<String, dynamic> map): 
		notifications = List<Notifications>.from(map["notifications"].map((it) => Notifications.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['notifications'] = notifications != null ? 
			this.notifications.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
