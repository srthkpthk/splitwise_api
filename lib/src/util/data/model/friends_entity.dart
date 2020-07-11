import 'package:json_annotation/json_annotation.dart';

part 'friends_entity.g.dart';

@JsonSerializable()
class FriendsEntity {
  List<FriendsBean> friends;

  FriendsEntity({this.friends});

  factory FriendsEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsEntityToJson(this);
}

@JsonSerializable()
class FriendsBean {
  num id;
  String first_name;
  dynamic last_name;
  String email;
  String registration_status;
  FriendsPictureBean picture;
  List<FriendsBalanceBean> balance;
  List<FriendsGroupsBean> groups;
  String updated_at;

  FriendsBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.registration_status,
      this.picture,
      this.balance,
      this.groups,
      this.updated_at});

  factory FriendsBean.fromJson(Map<String, dynamic> json) =>
      _$FriendsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsBeanToJson(this);
}

@JsonSerializable()
class FriendsGroupsBean {
  num group_id;
  List<FriendsBalanceBean> balance;

  FriendsGroupsBean({this.group_id, this.balance});

  factory FriendsGroupsBean.fromJson(Map<String, dynamic> json) =>
      _$FriendsGroupsBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsGroupsBeanToJson(this);
}

@JsonSerializable()
class FriendsBalanceBean {
  String currency_code;
  String amount;

  FriendsBalanceBean({this.currency_code, this.amount});

  factory FriendsBalanceBean.fromJson(Map<String, dynamic> json) =>
      _$FriendsBalanceBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsBalanceBeanToJson(this);
}

@JsonSerializable()
class FriendsPictureBean {
  String small;
  String medium;
  String large;

  FriendsPictureBean({this.small, this.medium, this.large});

  factory FriendsPictureBean.fromJson(Map<String, dynamic> json) =>
      _$FriendsPictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$FriendsPictureBeanToJson(this);
}
