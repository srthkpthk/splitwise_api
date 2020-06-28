import 'package:splitwise_api/src/util/data/model/friendsSection/friend/friend.dart';

class FriendEntity {

  final Friend friend;

	FriendEntity.fromJsonMap(Map<String, dynamic> map): 
		friend = Friend.fromJsonMap(map["friend"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['friend'] = friend == null ? null : friend.toJson();
		return data;
	}
}
