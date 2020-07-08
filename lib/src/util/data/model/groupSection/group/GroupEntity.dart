import 'package:splitwise_api/src/util/data/model/groupSection/group/group.dart';

class GroupEntity {

  final Group group;

	GroupEntity.fromJsonMap(Map<String, dynamic> map): 
		group = Group.fromJsonMap(map["group"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['group'] = group == null ? null : group.toJson();
		return data;
	}
}
