import 'package:splitwise_api/src/util/data/model/GroupsEntity/groups.dart';

class GroupsEntity {

  final List<GroupEntity> groups;

	GroupsEntity.fromJsonMap(Map<String, dynamic> map): 
		groups = List<GroupEntity>.from(map["groups"].map((it) => GroupEntity.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['groups'] = groups != null ? 
			this.groups.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
