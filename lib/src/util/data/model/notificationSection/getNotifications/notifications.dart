import 'package:splitwise_api/src/util/data/model/notificationSection/getNotifications/source.dart';

class Notifications {

  final int id;
  final int type;
  final String created_at;
  final int created_by;
  final Source source;
  final String image_url;
  final String image_shape;
  final String content;

	Notifications.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		type = map["type"],
		created_at = map["created_at"],
		created_by = map["created_by"],
		source = Source.fromJsonMap(map["source"]),
		image_url = map["image_url"],
		image_shape = map["image_shape"],
		content = map["content"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['type'] = type;
		data['created_at'] = created_at;
		data['created_by'] = created_by;
		data['source'] = source == null ? null : source.toJson();
		data['image_url'] = image_url;
		data['image_shape'] = image_shape;
		data['content'] = content;
		return data;
	}
}
