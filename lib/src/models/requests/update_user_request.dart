/// Fields that can be changed with `update_user`.
///
/// Only non-null fields are sent. Note that Splitwise may only allow a user
/// to update their own account, and some fields may be restricted for
/// accounts that were not created by your application.
final class UpdateUserRequest {
  /// Creates an update request.
  const UpdateUserRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.locale,
    this.defaultCurrency,
  });

  /// New first name.
  final String? firstName;

  /// New last name.
  final String? lastName;

  /// New email address.
  final String? email;

  /// New password.
  final String? password;

  /// New locale (for example `en`).
  final String? locale;

  /// New default currency as an ISO 4217 code.
  final String? defaultCurrency;

  /// Serializes the request, omitting unset fields.
  Map<String, Object?> toJson() => {
    if (firstName != null) 'first_name': firstName,
    if (lastName != null) 'last_name': lastName,
    if (email != null) 'email': email,
    if (password != null) 'password': password,
    if (locale != null) 'locale': locale,
    if (defaultCurrency != null) 'default_currency': defaultCurrency,
  };
}
