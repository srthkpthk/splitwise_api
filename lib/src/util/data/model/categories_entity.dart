import 'package:json_annotation/json_annotation.dart';

part 'categories_entity.g.dart';

@JsonSerializable()
class CategoriesEntity {
  List<CategoriesBean> categories;

  CategoriesEntity({this.categories});

  factory CategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesEntityToJson(this);
}

@JsonSerializable()
class CategoriesBean {
  num id;
  String name;
  String icon;
  CategoriesIcon_typesBean icon_types;
  List<SubcategoriesBean> subcategories;

  CategoriesBean(
      {this.id, this.name, this.icon, this.icon_types, this.subcategories});

  factory CategoriesBean.fromJson(Map<String, dynamic> json) =>
      _$CategoriesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesBeanToJson(this);
}

@JsonSerializable()
class SubcategoriesBean {
  num id;
  String name;
  String icon;
  CategoriesIcon_typesBean icon_types;

  SubcategoriesBean({this.id, this.name, this.icon, this.icon_types});

  factory SubcategoriesBean.fromJson(Map<String, dynamic> json) =>
      _$SubcategoriesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoriesBeanToJson(this);
}

@JsonSerializable()
class CategoriesIcon_typesBean {
  CategoriesSlimBean slim;
  CategoriesSquareBean square;

  CategoriesIcon_typesBean({this.slim, this.square});

  factory CategoriesIcon_typesBean.fromJson(Map<String, dynamic> json) =>
      _$CategoriesIcon_typesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesIcon_typesBeanToJson(this);
}

@JsonSerializable()
class CategoriesSquareBean {
  String large;
  String xlarge;

  CategoriesSquareBean({this.large, this.xlarge});

  factory CategoriesSquareBean.fromJson(Map<String, dynamic> json) =>
      _$CategoriesSquareBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesSquareBeanToJson(this);
}

@JsonSerializable()
class CategoriesSlimBean {
  String small;
  String large;

  CategoriesSlimBean({this.small, this.large});

  factory CategoriesSlimBean.fromJson(Map<String, dynamic> json) =>
      _$CategoriesSlimBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesSlimBeanToJson(this);
}
