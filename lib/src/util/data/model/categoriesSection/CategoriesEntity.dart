import 'package:splitwise_api/src/util/data/model/categoriesSection/categories.dart';

class CategoriesEntity {

  final List<Categories> categories;

	CategoriesEntity.fromJsonMap(Map<String, dynamic> map): 
		categories = List<Categories>.from(map["categories"].map((it) => Categories.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['categories'] = categories != null ? 
			this.categories.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
