import 'package:splitwise_api/src/util/data/model/NotificationsEntity/notifications.dart';

class NotificationsEntity {

  final List<Notifications> notifications;

	NotificationsEntity.fromJsonMap(Map<String, dynamic> map): 
		notifications = List<Notifications>.from(map["notifications"].map((it) => Notifications.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['notifications'] = notifications != null ? 
			this.notifications.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
