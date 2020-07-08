import 'package:splitwise_api/src/util/data/model/categoriesSection/icon_types.dart';

class Subcategories {

  final int id;
  final String name;
  final String icon;
  final Icon_types icon_types;

	Subcategories.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		icon = map["icon"],
		icon_types = Icon_types.fromJsonMap(map["icon_types"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['icon'] = icon;
		data['icon_types'] = icon_types == null ? null : icon_types.toJson();
		return data;
	}
}
