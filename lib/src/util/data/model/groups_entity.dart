import 'package:json_annotation/json_annotation.dart';

part 'groups_entity.g.dart';

@JsonSerializable()
class GroupsEntity {
  List<GroupsBean> groups;

  GroupsEntity({this.groups});

  factory GroupsEntity.fromJson(Map<String, dynamic> json) =>
      _$GroupsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsEntityToJson(this);
}

@JsonSerializable()
class GroupsBean {
  num id;
  String name;
  String created_at;
  String updated_at;
  List<GroupsMembersBean> members;
  bool simplify_by_default;
  List<GroupsOriginal_debtsBean> original_debts;
  List<GroupsSimplified_debtsBean> simplified_debts;
  GroupsAvatarBean avatar;
  bool custom_avatar;
  GroupsCover_photoBean cover_photo;

  GroupsBean(
      {this.id,
      this.name,
      this.created_at,
      this.updated_at,
      this.members,
      this.simplify_by_default,
      this.original_debts,
      this.simplified_debts,
      this.avatar,
      this.custom_avatar,
      this.cover_photo});

  factory GroupsBean.fromJson(Map<String, dynamic> json) =>
      _$GroupsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsBeanToJson(this);
}

@JsonSerializable()
class GroupsCover_photoBean {
  String xxlarge;
  String xlarge;

  GroupsCover_photoBean({this.xxlarge, this.xlarge});

  factory GroupsCover_photoBean.fromJson(Map<String, dynamic> json) =>
      _$GroupsCover_photoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsCover_photoBeanToJson(this);
}

@JsonSerializable()
class GroupsAvatarBean {
  dynamic original;
  String xxlarge;
  String xlarge;
  String large;
  String medium;
  String small;

  GroupsAvatarBean(
      {this.original,
      this.xxlarge,
      this.xlarge,
      this.large,
      this.medium,
      this.small});

  factory GroupsAvatarBean.fromJson(Map<String, dynamic> json) =>
      _$GroupsAvatarBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsAvatarBeanToJson(this);
}

@JsonSerializable()
class GroupsSimplified_debtsBean {
  String currency_code;
  num from;
  num to;
  String amount;

  GroupsSimplified_debtsBean(
      {this.currency_code, this.from, this.to, this.amount});

  factory GroupsSimplified_debtsBean.fromJson(Map<String, dynamic> json) =>
      _$GroupsSimplified_debtsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsSimplified_debtsBeanToJson(this);
}

@JsonSerializable()
class GroupsOriginal_debtsBean {
  String currency_code;
  num from;
  num to;
  String amount;

  GroupsOriginal_debtsBean(
      {this.currency_code, this.from, this.to, this.amount});

  factory GroupsOriginal_debtsBean.fromJson(Map<String, dynamic> json) =>
      _$GroupsOriginal_debtsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsOriginal_debtsBeanToJson(this);
}

@JsonSerializable()
class GroupsMembersBean {
  num id;
  String first_name;
  String last_name;
  GroupsPictureBean picture;
  bool custom_picture;
  String email;
  String registration_status;
  List<GroupsBalanceBean> balance;

  GroupsMembersBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.picture,
      this.custom_picture,
      this.email,
      this.registration_status,
      this.balance});

  factory GroupsMembersBean.fromJson(Map<String, dynamic> json) =>
      _$GroupsMembersBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsMembersBeanToJson(this);
}

@JsonSerializable()
class GroupsBalanceBean {
  String amount;
  String currency_code;

  GroupsBalanceBean({this.amount, this.currency_code});

  factory GroupsBalanceBean.fromJson(Map<String, dynamic> json) =>
      _$GroupsBalanceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsBalanceBeanToJson(this);
}

@JsonSerializable()
class GroupsPictureBean {
  String small;
  String medium;
  String large;

  GroupsPictureBean({this.small, this.medium, this.large});

  factory GroupsPictureBean.fromJson(Map<String, dynamic> json) =>
      _$GroupsPictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$GroupsPictureBeanToJson(this);
}
