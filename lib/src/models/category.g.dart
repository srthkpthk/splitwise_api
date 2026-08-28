// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconSizes _$IconSizesFromJson(Map<String, dynamic> json) => IconSizes(
  small: json['small'] as String?,
  large: json['large'] as String?,
  xlarge: json['xlarge'] as String?,
);

Map<String, dynamic> _$IconSizesToJson(IconSizes instance) => <String, dynamic>{
  'small': ?instance.small,
  'large': ?instance.large,
  'xlarge': ?instance.xlarge,
};

IconTypes _$IconTypesFromJson(Map<String, dynamic> json) => IconTypes(
  slim: json['slim'] == null
      ? null
      : IconSizes.fromJson(json['slim'] as Map<String, dynamic>),
  square: json['square'] == null
      ? null
      : IconSizes.fromJson(json['square'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IconTypesToJson(IconTypes instance) => <String, dynamic>{
  'slim': ?instance.slim?.toJson(),
  'square': ?instance.square?.toJson(),
};

SplitwiseCategory _$SplitwiseCategoryFromJson(Map<String, dynamic> json) =>
    SplitwiseCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      iconTypes: json['icon_types'] == null
          ? null
          : IconTypes.fromJson(json['icon_types'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SplitwiseCategoryToJson(SplitwiseCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': ?instance.name,
      'icon': ?instance.icon,
      'icon_types': ?instance.iconTypes?.toJson(),
    };

SplitwiseParentCategory _$SplitwiseParentCategoryFromJson(
  Map<String, dynamic> json,
) => SplitwiseParentCategory(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  icon: json['icon'] as String?,
  iconTypes: json['icon_types'] == null
      ? null
      : IconTypes.fromJson(json['icon_types'] as Map<String, dynamic>),
  subcategories:
      (json['subcategories'] as List<dynamic>?)
          ?.map((e) => SplitwiseCategory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SplitwiseParentCategoryToJson(
  SplitwiseParentCategory instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': ?instance.name,
  'icon': ?instance.icon,
  'icon_types': ?instance.iconTypes?.toJson(),
  'subcategories': instance.subcategories.map((e) => e.toJson()).toList(),
};
