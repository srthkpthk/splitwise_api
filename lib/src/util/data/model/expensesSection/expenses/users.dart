import 'package:splitwise_api/src/util/data/model/expensesSection/expenses/user.dart';

class Users {

  final User user;
  final int user_id;
  final String paid_share;
  final String owed_share;
  final String net_balance;

	Users.fromJsonMap(Map<String, dynamic> map): 
		user = User.fromJsonMap(map["user"]),
		user_id = map["user_id"],
		paid_share = map["paid_share"],
		owed_share = map["owed_share"],
		net_balance = map["net_balance"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['user'] = user == null ? null : user.toJson();
		data['user_id'] = user_id;
		data['paid_share'] = paid_share;
		data['owed_share'] = owed_share;
		data['net_balance'] = net_balance;
		return data;
	}
}
