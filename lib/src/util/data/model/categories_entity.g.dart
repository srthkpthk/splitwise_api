// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesEntity _$CategoriesEntityFromJson(Map<String, dynamic> json) {
  return CategoriesEntity(
    categories: (json['categories'] as List)
        ?.map((e) => e == null
            ? null
            : CategoriesBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoriesEntityToJson(CategoriesEntity instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

CategoriesBean _$CategoriesBeanFromJson(Map<String, dynamic> json) {
  return CategoriesBean(
    id: json['id'] as num,
    name: json['name'] as String,
    icon: json['icon'] as String,
    icon_types: json['icon_types'] == null
        ? null
        : CategoriesIcon_typesBean.fromJson(
            json['icon_types'] as Map<String, dynamic>),
    subcategories: (json['subcategories'] as List)
        ?.map((e) => e == null
            ? null
            : SubcategoriesBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoriesBeanToJson(CategoriesBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'icon_types': instance.icon_types,
      'subcategories': instance.subcategories,
    };

SubcategoriesBean _$SubcategoriesBeanFromJson(Map<String, dynamic> json) {
  return SubcategoriesBean(
    id: json['id'] as num,
    name: json['name'] as String,
    icon: json['icon'] as String,
    icon_types: json['icon_types'] == null
        ? null
        : CategoriesIcon_typesBean.fromJson(
            json['icon_types'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SubcategoriesBeanToJson(SubcategoriesBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'icon_types': instance.icon_types,
    };

CategoriesIcon_typesBean _$CategoriesIcon_typesBeanFromJson(
    Map<String, dynamic> json) {
  return CategoriesIcon_typesBean(
    slim: json['slim'] == null
        ? null
        : CategoriesSlimBean.fromJson(json['slim'] as Map<String, dynamic>),
    square: json['square'] == null
        ? null
        : CategoriesSquareBean.fromJson(json['square'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CategoriesIcon_typesBeanToJson(
        CategoriesIcon_typesBean instance) =>
    <String, dynamic>{
      'slim': instance.slim,
      'square': instance.square,
    };

CategoriesSquareBean _$CategoriesSquareBeanFromJson(Map<String, dynamic> json) {
  return CategoriesSquareBean(
    large: json['large'] as String,
    xlarge: json['xlarge'] as String,
  );
}

Map<String, dynamic> _$CategoriesSquareBeanToJson(
        CategoriesSquareBean instance) =>
    <String, dynamic>{
      'large': instance.large,
      'xlarge': instance.xlarge,
    };

CategoriesSlimBean _$CategoriesSlimBeanFromJson(Map<String, dynamic> json) {
  return CategoriesSlimBean(
    small: json['small'] as String,
    large: json['large'] as String,
  );
}

Map<String, dynamic> _$CategoriesSlimBeanToJson(CategoriesSlimBean instance) =>
    <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };
