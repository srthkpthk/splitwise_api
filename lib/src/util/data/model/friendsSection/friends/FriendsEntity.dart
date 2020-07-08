import 'package:splitwise_api/src/util/data/model/friendsSection/friends/friends.dart';

class FriendsEntity {

  final List<Friends> friends;

	FriendsEntity.fromJsonMap(Map<String, dynamic> map): 
		friends = List<Friends>.from(map["friends"].map((it) => Friends.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['friends'] = friends != null ? 
			this.friends.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
