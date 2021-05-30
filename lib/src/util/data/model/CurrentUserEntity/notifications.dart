
class Notifications {

  final bool added_as_friend;

	Notifications.fromJsonMap(Map<String, dynamic> map): 
		added_as_friend = map["added_as_friend"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['added_as_friend'] = added_as_friend;
		return data;
	}
}
