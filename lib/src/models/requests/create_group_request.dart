import '../enums.dart';
import 'flatten.dart';

/// A member to add when creating a group: either an existing user by ID or a
/// new user by email.
sealed class GroupMemberInput {
  const GroupMemberInput();

  /// An existing Splitwise user identified by [userId].
  const factory GroupMemberInput.user(int userId) = ExistingGroupMember;

  /// A user identified by [email]; Splitwise invites them if they have no
  /// account yet.
  const factory GroupMemberInput.newUser({
    required String email,
    String? firstName,
    String? lastName,
  }) = NewGroupMember;

  /// Serializes this member to the properties Splitwise expects.
  Map<String, Object?> toJson();
}

/// A [GroupMemberInput] referring to an existing user.
final class ExistingGroupMember extends GroupMemberInput {
  /// Creates a member reference by user ID.
  const ExistingGroupMember(this.userId);

  /// ID of the existing user.
  final int userId;

  @override
  Map<String, Object?> toJson() => {'user_id': userId};
}

/// A [GroupMemberInput] identified by email address.
final class NewGroupMember extends GroupMemberInput {
  /// Creates a member reference by email.
  const NewGroupMember({required this.email, this.firstName, this.lastName});

  /// Email address of the user.
  final String email;

  /// First name, used if the user has no account yet.
  final String? firstName;

  /// Last name, used if the user has no account yet.
  final String? lastName;

  @override
  Map<String, Object?> toJson() => {
    if (firstName != null) 'first_name': firstName,
    if (lastName != null) 'last_name': lastName,
    'email': email,
  };
}

/// Payload for `create_group`.
///
/// The current user is always added to the group; [members] lists additional
/// members and is flattened to `users__{index}__{property}` keys.
final class CreateGroupRequest {
  /// Creates a group request.
  const CreateGroupRequest({
    required this.name,
    this.groupType,
    this.simplifyByDefault,
    this.members = const [],
  });

  /// Display name of the group.
  final String name;

  /// What kind of group this is.
  final GroupType? groupType;

  /// Whether to simplify debts within the group by default.
  final bool? simplifyByDefault;

  /// Additional members to add on creation.
  final List<GroupMemberInput> members;

  /// Serializes the request, omitting unset fields.
  Map<String, Object?> toJson() => {
    'name': name,
    if (groupType != null) 'group_type': groupType!.wireName,
    if (simplifyByDefault != null) 'simplify_by_default': simplifyByDefault,
    ...flattenUsers(members.map((member) => member.toJson())),
  };
}
