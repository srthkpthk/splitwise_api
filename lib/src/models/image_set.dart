import 'package:json_annotation/json_annotation.dart';

part 'image_set.g.dart';

/// A set of image URLs at different sizes.
///
/// Splitwise returns a different subset of sizes depending on the object
/// (`user.picture`, `comment.user.picture`, `group.avatar`,
/// `group.cover_photo`); every size is therefore optional.
@JsonSerializable()
class ImageSet {
  /// Creates an image set.
  const ImageSet({
    this.original,
    this.xxlarge,
    this.xlarge,
    this.large,
    this.medium,
    this.small,
  });

  /// Deserializes an image set.
  factory ImageSet.fromJson(Map<String, dynamic> json) =>
      _$ImageSetFromJson(json);

  /// URL of the original upload, when present.
  final String? original;

  /// URL of the extra-extra-large rendition.
  final String? xxlarge;

  /// URL of the extra-large rendition.
  final String? xlarge;

  /// URL of the large rendition.
  final String? large;

  /// URL of the medium rendition.
  final String? medium;

  /// URL of the small rendition.
  final String? small;

  /// Serializes this image set.
  Map<String, dynamic> toJson() => _$ImageSetToJson(this);
}
