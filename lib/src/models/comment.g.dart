// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentUser _$CommentUserFromJson(Map<String, dynamic> json) => CommentUser(
  id: (json['id'] as num).toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  picture: json['picture'] == null
      ? null
      : ImageSet.fromJson(json['picture'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentUserToJson(CommentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': ?instance.firstName,
      'last_name': ?instance.lastName,
      'picture': ?instance.picture?.toJson(),
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String?,
  commentType: $enumDecodeNullable(
    _$CommentTypeEnumMap,
    json['comment_type'],
    unknownValue: CommentType.unknown,
  ),
  relationType: $enumDecodeNullable(
    _$RelationTypeEnumMap,
    json['relation_type'],
    unknownValue: RelationType.unknown,
  ),
  relationId: (json['relation_id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
  user: json['user'] == null
      ? null
      : CommentUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
  'id': instance.id,
  'content': ?instance.content,
  'comment_type': ?_$CommentTypeEnumMap[instance.commentType],
  'relation_type': ?_$RelationTypeEnumMap[instance.relationType],
  'relation_id': ?instance.relationId,
  'created_at': ?instance.createdAt?.toUtc().toIso8601String(),
  'deleted_at': ?instance.deletedAt?.toUtc().toIso8601String(),
  'user': ?instance.user?.toJson(),
};

const _$CommentTypeEnumMap = {
  CommentType.system: 'System',
  CommentType.user: 'User',
  CommentType.unknown: 'unknown',
};

const _$RelationTypeEnumMap = {
  RelationType.expenseComment: 'ExpenseComment',
  RelationType.unknown: 'unknown',
};
