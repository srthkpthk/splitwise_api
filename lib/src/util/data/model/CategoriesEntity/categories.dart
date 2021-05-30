import 'package:splitwise_api/src/util/data/model/CategoriesEntity/icon_types.dart';
import 'package:splitwise_api/src/util/data/model/CategoriesEntity/subcategories.dart';

class Categories {

  final int id;
  final String name;
  final String icon;
  final Icon_types icon_types;
  final List<Subcategories> subcategories;

	Categories.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		icon = map["icon"],
		icon_types = Icon_types.fromJsonMap(map["icon_types"]),
		subcategories = List<Subcategories>.from(map["subcategories"].map((it) => Subcategories.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['icon'] = icon;
		data['icon_types'] = icon_types == null ? null : icon_types.toJson();
		data['subcategories'] = subcategories != null ? 
			this.subcategories.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
