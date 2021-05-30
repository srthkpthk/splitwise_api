import 'package:splitwise_api/src/util/data/model/ExpensesEntity/picture.dart';

class Updated_by {

  final int id;
  final String first_name;
  final String last_name;
  final String email;
  final String registration_status;
  final Picture picture;

	Updated_by.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		first_name = map["first_name"],
		last_name = map["last_name"],
		email = map["email"],
		registration_status = map["registration_status"],
		picture = Picture.fromJsonMap(map["picture"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['first_name'] = first_name;
		data['last_name'] = last_name;
		data['email'] = email;
		data['registration_status'] = registration_status;
		data['picture'] = picture == null ? null : picture.toJson();
		return data;
	}
}
