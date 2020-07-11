import 'package:json_annotation/json_annotation.dart';

part 'single_user_entity.g.dart';

@JsonSerializable()
class SingleUserEntity {
  SingleUserBean user;

  SingleUserEntity({this.user});

  factory SingleUserEntity.fromJson(Map<String, dynamic> json) =>
      _$SingleUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SingleUserEntityToJson(this);
}

@JsonSerializable()
class SingleUserBean {
  num id;
  String first_name;
  String last_name;
  SingleUserPictureBean picture;
  bool custom_picture;
  String email;
  String registration_status;

  SingleUserBean(
      {this.id,
      this.first_name,
      this.last_name,
      this.picture,
      this.custom_picture,
      this.email,
      this.registration_status});

  factory SingleUserBean.fromJson(Map<String, dynamic> json) =>
      _$SingleUserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SingleUserBeanToJson(this);
}

@JsonSerializable()
class SingleUserPictureBean {
  String small;
  String medium;
  String large;

  SingleUserPictureBean({this.small, this.medium, this.large});

  factory SingleUserPictureBean.fromJson(Map<String, dynamic> json) =>
      _$SingleUserPictureBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SingleUserPictureBeanToJson(this);
}
