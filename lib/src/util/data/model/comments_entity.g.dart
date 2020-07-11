// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentsEntity _$CommentsEntityFromJson(Map<String, dynamic> json) {
  return CommentsEntity(
    comments: (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : CommentsBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CommentsEntityToJson(CommentsEntity instance) =>
    <String, dynamic>{
      'comments': instance.comments,
    };

CommentsBean _$CommentsBeanFromJson(Map<String, dynamic> json) {
  return CommentsBean(
    id: json['id'] as num,
    content: json['content'] as String,
    comment_type: json['comment_type'] as String,
    relation_type: json['relation_type'] as String,
    relation_id: json['relation_id'] as num,
    created_at: json['created_at'] as String,
    deleted_at: json['deleted_at'],
    user: json['user'] == null
        ? null
        : CommentsUserBean.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentsBeanToJson(CommentsBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'comment_type': instance.comment_type,
      'relation_type': instance.relation_type,
      'relation_id': instance.relation_id,
      'created_at': instance.created_at,
      'deleted_at': instance.deleted_at,
      'user': instance.user,
    };

CommentsUserBean _$CommentsUserBeanFromJson(Map<String, dynamic> json) {
  return CommentsUserBean(
    id: json['id'] as num,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    picture: json['picture'] == null
        ? null
        : CommentsPictureBean.fromJson(json['picture'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentsUserBeanToJson(CommentsUserBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'picture': instance.picture,
    };

CommentsPictureBean _$CommentsPictureBeanFromJson(Map<String, dynamic> json) {
  return CommentsPictureBean(
    medium: json['medium'] as String,
  );
}

Map<String, dynamic> _$CommentsPictureBeanToJson(
        CommentsPictureBean instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };
