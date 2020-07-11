import 'package:json_annotation/json_annotation.dart';

part 'group_entity.g.dart';

@JsonSerializable()
class GroupEntity {
  GroupBean group;

  GroupEntity({this.group});

  factory GroupEntity.fromJson(Map<String, dynamic> json) =>
      _$GroupEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GroupEntityToJson(this);
}

@JsonSerializable()
class GroupBean {
  num id;
  String name;
  String created_at;
  String updated_at;
  List<GroupMembersBean> members;
  bool simplify_by_default;
  List<GroupOriginal_debtsBean> original_debts;
  List<GroupSimplified_debtsBean> simplified_debts;
  dynamic whiteboard;
  String group_type;
  String invite_link;
  GroupAvatarBean avatar;
  bool custom_avatar;
  GroupCover_photoBean cover_photo;

  GroupBean(
      {this.id,
      this.name,
      this.created_at,
      this.updated_at,
      this.members,
      this.simplify_by_default,
      this.original_debts,
      this.simplified_debts,
      this.whiteboard,
      this.group_type,
      this.invite_link,
      this.avatar,
      this.custom_avatar,
      this.cover_photo});

  factory GroupBean.fromJson(Map<String, dynamic> json) =>
      _$GroupBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupBeanToJson(this);
}

@JsonSerializable()
class GroupCover_photoBean {
  String xxlarge;
  String xlarge;

  GroupCover_photoBean({this.xxlarge, this.xlarge});

  factory GroupCover_photoBean.fromJson(Map<String, dynamic> json) =>
      _$GroupCover_photoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupCover_photoBeanToJson(this);
}

@JsonSerializable()
class GroupAvatarBean {
  String original;
  String xxlarge;
  String xlarge;
  String large;
  String medium;
  String small;

  GroupAvatarBean(
      {this.original,
      this.xxlarge,
      this.xlarge,
      this.large,
      this.medium,
      this.small});

  factory GroupAvatarBean.fromJson(Map<String, dynamic> json) =>
      _$GroupAvatarBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupAvatarBeanToJson(this);
}

@JsonSerializable()
class GroupSimplified_debtsBean {
  num from;
  num to;
  String amount;
  String currency_code;

  GroupSimplified_debtsBean(
      {this.from, this.to, this.amount, this.currency_code});

  factory GroupSimplified_debtsBean.fromJson(Map<String, dynamic> json) =>
      _$GroupSimplified_debtsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupSimplified_debtsBeanToJson(this);
}

@JsonSerializable()
class GroupOriginal_debtsBean {
  num to;
  num from;
  String amount;
  String currency_code;

  GroupOriginal_debtsBean(
      {this.to, this.from, this.amount, this.currency_code});

  factory GroupOriginal_debtsBean.fromJson(Map<String, dynamic> json) =>
      _$GroupOriginal_debtsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupOriginal_debtsBeanToJson(this);
}

@JsonSerializable()
class GroupMembersBean {
  num id;
  String first_name;
  String last_name;
  GroupPictureBean picture;
  bool custom_picture;
  String email;
  String registration_status;
  List<GroupBalanceBean> balance;

  GroupMembersBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.picture,
      this.custom_picture,
      this.email,
      this.registration_status,
      this.balance});

  factory GroupMembersBean.fromJson(Map<String, dynamic> json) =>
      _$GroupMembersBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMembersBeanToJson(this);
}

@JsonSerializable()
class GroupBalanceBean {
  String currency_code;
  String amount;

  GroupBalanceBean({this.currency_code, this.amount});

  factory GroupBalanceBean.fromJson(Map<String, dynamic> json) =>
      _$GroupBalanceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupBalanceBeanToJson(this);
}

@JsonSerializable()
class GroupPictureBean {
  String small;
  String medium;
  String large;

  GroupPictureBean({this.small, this.medium, this.large});

  factory GroupPictureBean.fromJson(Map<String, dynamic> json) =>
      _$GroupPictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupPictureBeanToJson(this);
}
