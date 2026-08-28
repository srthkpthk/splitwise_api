import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

/// Icon URLs for one icon style at different sizes.
@JsonSerializable()
class IconSizes {
  /// Creates icon sizes.
  const IconSizes({this.small, this.large, this.xlarge});

  /// Deserializes icon sizes.
  factory IconSizes.fromJson(Map<String, dynamic> json) =>
      _$IconSizesFromJson(json);

  /// URL of the small rendition.
  final String? small;

  /// URL of the large rendition.
  final String? large;

  /// URL of the extra-large rendition.
  final String? xlarge;

  /// Serializes these icon sizes.
  Map<String, dynamic> toJson() => _$IconSizesToJson(this);
}

/// The icon styles available for a category.
@JsonSerializable()
class IconTypes {
  /// Creates icon types.
  const IconTypes({this.slim, this.square});

  /// Deserializes icon types.
  factory IconTypes.fromJson(Map<String, dynamic> json) =>
      _$IconTypesFromJson(json);

  /// The slim (outline) icon style.
  final IconSizes? slim;

  /// The square (filled) icon style.
  final IconSizes? square;

  /// Serializes these icon types.
  Map<String, dynamic> toJson() => _$IconTypesToJson(this);
}

/// An expense category.
///
/// Named `SplitwiseCategory` to avoid clashing with Flutter's `Category`
/// annotation. When nested in an [Expense] only [id] and [name] are set.
@JsonSerializable()
class SplitwiseCategory {
  /// Creates a category.
  const SplitwiseCategory({
    required this.id,
    this.name,
    this.icon,
    this.iconTypes,
  });

  /// Deserializes a category.
  factory SplitwiseCategory.fromJson(Map<String, dynamic> json) =>
      _$SplitwiseCategoryFromJson(json);

  /// Unique identifier of the category.
  final int id;

  /// Display name of the category.
  final String? name;

  /// URL of the category's default icon.
  final String? icon;

  /// Icon URLs in each available style and size.
  final IconTypes? iconTypes;

  /// Serializes this category.
  Map<String, dynamic> toJson() => _$SplitwiseCategoryToJson(this);
}

/// A top-level category together with its subcategories, as returned by
/// `get_categories`.
@JsonSerializable()
class SplitwiseParentCategory extends SplitwiseCategory {
  /// Creates a parent category.
  const SplitwiseParentCategory({
    required super.id,
    super.name,
    super.icon,
    super.iconTypes,
    this.subcategories = const [],
  });

  /// Deserializes a parent category.
  factory SplitwiseParentCategory.fromJson(Map<String, dynamic> json) =>
      _$SplitwiseParentCategoryFromJson(json);

  /// The categories an expense can actually be assigned to.
  final List<SplitwiseCategory> subcategories;

  @override
  Map<String, dynamic> toJson() => _$SplitwiseParentCategoryToJson(this);
}
