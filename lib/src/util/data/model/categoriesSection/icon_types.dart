import 'package:splitwise_api/src/util/data/model/categoriesSection/slim.dart';
import 'package:splitwise_api/src/util/data/model/categoriesSection/square.dart';

class Icon_types {

  final Slim slim;
  final Square square;

	Icon_types.fromJsonMap(Map<String, dynamic> map): 
		slim = Slim.fromJsonMap(map["slim"]),
		square = Square.fromJsonMap(map["square"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['slim'] = slim == null ? null : slim.toJson();
		data['square'] = square == null ? null : square.toJson();
		return data;
	}
}
