import 'package:splitwise_api/src/util/data/model/FriendsEntity/friends.dart';

class FriendsEntity {

  final List<FriendEntity> friends;

	FriendsEntity.fromJsonMap(Map<String, dynamic> map): 
		friends = List<FriendEntity>.from(map["friends"].map((it) => FriendEntity.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['friends'] = friends != null ? 
			this.friends.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
