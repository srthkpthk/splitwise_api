/// A user to befriend with `create_friends`.
///
/// If no Splitwise account exists for [email], one is created using
/// [firstName] and [lastName] and the user is invited.
final class NewFriend {
  /// Creates a friend request entry.
  const NewFriend({required this.email, this.firstName, this.lastName});

  /// Email address of the user.
  final String email;

  /// First name, used if the user has no account yet.
  final String? firstName;

  /// Last name, used if the user has no account yet.
  final String? lastName;

  /// Serializes this entry to the properties Splitwise expects.
  Map<String, Object?> toJson() => {
    if (firstName != null) 'first_name': firstName,
    if (lastName != null) 'last_name': lastName,
    'email': email,
  };
}
