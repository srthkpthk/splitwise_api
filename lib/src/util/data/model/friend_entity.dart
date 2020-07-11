import 'package:json_annotation/json_annotation.dart';

part 'friend_entity.g.dart';

@JsonSerializable()
class FriendEntity {
  FriendBean friend;

  FriendEntity({this.friend});

  factory FriendEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendEntityToJson(this);
}

@JsonSerializable()
class FriendBean {
  num id;
  String first_name;
  dynamic last_name;
  String email;
  String registration_status;
  FriendPictureBean picture;
  List<FriendBalanceBean> balance;
  List<FriendGroupsBean> groups;
  String updated_at;

  FriendBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.registration_status,
      this.picture,
      this.balance,
      this.groups,
      this.updated_at});

  factory FriendBean.fromJson(Map<String, dynamic> json) =>
      _$FriendBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FriendBeanToJson(this);
}

@JsonSerializable()
class FriendGroupsBean {
  num group_id;
  List<FriendBalanceBean> balance;

  FriendGroupsBean({this.group_id, this.balance});

  factory FriendGroupsBean.fromJson(Map<String, dynamic> json) =>
      _$FriendGroupsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FriendGroupsBeanToJson(this);
}

@JsonSerializable()
class FriendBalanceBean {
  String currency_code;
  String amount;

  FriendBalanceBean({this.currency_code, this.amount});

  factory FriendBalanceBean.fromJson(Map<String, dynamic> json) =>
      _$FriendBalanceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FriendBalanceBeanToJson(this);
}

@JsonSerializable()
class FriendPictureBean {
  String small;
  String medium;
  String large;

  FriendPictureBean({this.small, this.medium, this.large});

  factory FriendPictureBean.fromJson(Map<String, dynamic> json) =>
      _$FriendPictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FriendPictureBeanToJson(this);
}
