import 'package:splitwise_api/src/util/data/model/common/user.dart';

class Comments {
  final int id;
  final String content;
  final String comment_type;
  final String relation_type;
  final int relation_id;
  final String created_at;
  final Object deleted_at;
  final User user;

  Comments.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        content = map["content"],
        comment_type = map["comment_type"],
        relation_type = map["relation_type"],
        relation_id = map["relation_id"],
        created_at = map["created_at"],
        deleted_at = map["deleted_at"],
        user = User.fromJsonMap(map["user"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['content'] = content;
    data['comment_type'] = comment_type;
    data['relation_type'] = relation_type;
    data['relation_id'] = relation_id;
    data['created_at'] = created_at;
    data['deleted_at'] = deleted_at;
    data['user'] = user == null ? null : user.toJson();
    return data;
  }
}
