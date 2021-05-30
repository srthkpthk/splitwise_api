import 'package:splitwise_api/src/util/data/model/GroupsEntity/members.dart';
import 'package:splitwise_api/src/util/data/model/GroupsEntity/original_debts.dart';
import 'package:splitwise_api/src/util/data/model/GroupsEntity/simplified_debts.dart';
import 'package:splitwise_api/src/util/data/model/GroupsEntity/avatar.dart';
import 'package:splitwise_api/src/util/data/model/GroupsEntity/cover_photo.dart';

class GroupEntity {

  final int id;
  final String name;
  final String group_type;
  final String updated_at;
  final bool simplify_by_default;
  final List<Members> members;
  final List<Original_debts> original_debts;
  final List<Simplified_debts> simplified_debts;
  final Avatar avatar;
  final bool custom_avatar;
  final Cover_photo cover_photo;
  final String invite_link;

	GroupEntity.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		group_type = map["group_type"],
		updated_at = map["updated_at"],
		simplify_by_default = map["simplify_by_default"],
		members = List<Members>.from(map["members"].map((it) => Members.fromJsonMap(it))),
		original_debts = List<Original_debts>.from(map["original_debts"].map((it) => Original_debts.fromJsonMap(it))),
		simplified_debts = List<Simplified_debts>.from(map["simplified_debts"].map((it) => Simplified_debts.fromJsonMap(it))),
		avatar = Avatar.fromJsonMap(map["avatar"]),
		custom_avatar = map["custom_avatar"],
		cover_photo = Cover_photo.fromJsonMap(map["cover_photo"]),
		invite_link = map["invite_link"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['group_type'] = group_type;
		data['updated_at'] = updated_at;
		data['simplify_by_default'] = simplify_by_default;
		data['members'] = members != null ? 
			this.members.map((v) => v.toJson()).toList()
			: null;
		data['original_debts'] = original_debts != null ? 
			this.original_debts.map((v) => v.toJson()).toList()
			: null;
		data['simplified_debts'] = simplified_debts != null ? 
			this.simplified_debts.map((v) => v.toJson()).toList()
			: null;
		data['avatar'] = avatar == null ? null : avatar.toJson();
		data['custom_avatar'] = custom_avatar;
		data['cover_photo'] = cover_photo == null ? null : cover_photo.toJson();
		data['invite_link'] = invite_link;
		return data;
	}
}
