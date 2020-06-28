import 'package:splitwise_api/src/util/data/model/expensesSection/postExpense/picture.dart';

class Created_by {

  final int id;
  final String first_name;
  final String last_name;
  final Picture picture;
  final bool custom_picture;

	Created_by.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		first_name = map["first_name"],
		last_name = map["last_name"],
		picture = Picture.fromJsonMap(map["picture"]),
		custom_picture = map["custom_picture"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['first_name'] = first_name;
		data['last_name'] = last_name;
		data['picture'] = picture == null ? null : picture.toJson();
		data['custom_picture'] = custom_picture;
		return data;
	}
}
