import 'package:json_annotation/json_annotation.dart';

import 'balance.dart';
import 'enums.dart';
import 'image_set.dart';
import 'user.dart';

part 'group.g.dart';

/// A member of a group: a [User] plus their balances within the group.
@JsonSerializable()
class GroupMember extends User {
  /// Creates a group member.
  const GroupMember({
    required super.id,
    super.firstName,
    super.lastName,
    super.email,
    super.registrationStatus,
    super.picture,
    super.customPicture,
    this.balance = const [],
  });

  /// Deserializes a group member.
  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);

  /// The member's balance in each currency used by the group.
  final List<Balance> balance;

  @override
  Map<String, dynamic> toJson() => _$GroupMemberToJson(this);
}

/// A Splitwise group.
///
/// The group with [id] `0` is the pseudo-group holding expenses that are not
/// in any group.
@JsonSerializable()
class Group {
  /// Creates a group.
  const Group({
    required this.id,
    this.name,
    this.groupType,
    this.updatedAt,
    this.simplifyByDefault,
    this.members = const [],
    this.originalDebts = const [],
    this.simplifiedDebts = const [],
    this.avatar,
    this.customAvatar,
    this.coverPhoto,
    this.inviteLink,
  });

  /// Deserializes a group.
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  /// Unique identifier of the group.
  final int id;

  /// Display name of the group.
  final String? name;

  /// What kind of group this is.
  @JsonKey(unknownEnumValue: GroupType.unknown)
  final GroupType? groupType;

  /// When the group was last modified.
  final DateTime? updatedAt;

  /// Whether debts are simplified within the group by default.
  final bool? simplifyByDefault;

  /// Members of the group.
  final List<GroupMember> members;

  /// Debts before simplification.
  final List<Debt> originalDebts;

  /// Debts after simplification.
  final List<Debt> simplifiedDebts;

  /// The group's avatar image.
  final ImageSet? avatar;

  /// Whether [avatar] was uploaded by a member.
  final bool? customAvatar;

  /// The group's cover photo.
  final ImageSet? coverPhoto;

  /// Link that lets other users join the group.
  final String? inviteLink;

  /// Serializes this group.
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
