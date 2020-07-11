import 'package:json_annotation/json_annotation.dart';

part 'comments_entity.g.dart';

@JsonSerializable()
class CommentsEntity {
  List<CommentsBean> comments;

  CommentsEntity({this.comments});

  factory CommentsEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsEntityToJson(this);
}

@JsonSerializable()
class CommentsBean {
  num id;
  String content;
  String comment_type;
  String relation_type;
  num relation_id;
  String created_at;
  dynamic deleted_at;
  CommentsUserBean user;

  CommentsBean(
      {this.id,
      this.content,
      this.comment_type,
      this.relation_type,
      this.relation_id,
      this.created_at,
      this.deleted_at,
      this.user});

  factory CommentsBean.fromJson(Map<String, dynamic> json) =>
      _$CommentsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsBeanToJson(this);
}

@JsonSerializable()
class CommentsUserBean {
  num id;
  String first_name;
  String last_name;
  CommentsPictureBean picture;

  CommentsUserBean({this.id, this.first_name, this.last_name, this.picture});

  factory CommentsUserBean.fromJson(Map<String, dynamic> json) =>
      _$CommentsUserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsUserBeanToJson(this);
}

@JsonSerializable()
class CommentsPictureBean {
  String medium;

  CommentsPictureBean({this.medium});

  factory CommentsPictureBean.fromJson(Map<String, dynamic> json) =>
      _$CommentsPictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsPictureBeanToJson(this);
}
