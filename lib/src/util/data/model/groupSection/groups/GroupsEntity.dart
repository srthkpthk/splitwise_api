import 'package:splitwise_api/src/util/data/model/groupSection/groups/groups.dart';

class GroupsEntity {

  final List<Groups> groups;

	GroupsEntity.fromJsonMap(Map<String, dynamic> map): 
		groups = List<Groups>.from(map["groups"].map((it) => Groups.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['groups'] = groups != null ? 
			this.groups.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
