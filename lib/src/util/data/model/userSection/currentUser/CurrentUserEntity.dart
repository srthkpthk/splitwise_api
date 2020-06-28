
import 'package:splitwise_api/src/util/data/model/userSection/currentUser/user.dart';

class CurrentUserEntity {

  final User user;

	CurrentUserEntity.fromJsonMap(Map<String, dynamic> map): 
		user = User.fromJsonMap(map["user"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['user'] = user == null ? null : user.toJson();
		return data;
	}
}
