import 'package:json_annotation/json_annotation.dart';

import 'balance.dart';
import 'enums.dart';
import 'image_set.dart';
import 'user.dart';

part 'friend.g.dart';

/// A friend's balance within one shared group.
@JsonSerializable()
class FriendGroupBalance {
  /// Creates a per-group balance.
  const FriendGroupBalance({this.groupId, this.balance = const []});

  /// Deserializes a per-group balance.
  factory FriendGroupBalance.fromJson(Map<String, dynamic> json) =>
      _$FriendGroupBalanceFromJson(json);

  /// ID of the shared group.
  final int? groupId;

  /// Balances with this friend inside the group, one per currency.
  final List<Balance> balance;

  /// Serializes this per-group balance.
  Map<String, dynamic> toJson() => _$FriendGroupBalanceToJson(this);
}

/// A friend of the current user: a [User] plus the balances shared with them.
@JsonSerializable()
class Friend extends User {
  /// Creates a friend.
  const Friend({
    required super.id,
    super.firstName,
    super.lastName,
    super.email,
    super.registrationStatus,
    super.picture,
    super.customPicture,
    this.groups = const [],
    this.balance = const [],
    this.updatedAt,
  });

  /// Deserializes a friend.
  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  /// Balances with this friend broken down by shared group.
  final List<FriendGroupBalance> groups;

  /// Overall balances with this friend, one per currency.
  final List<Balance> balance;

  /// When the friendship was last modified.
  final DateTime? updatedAt;

  @override
  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
