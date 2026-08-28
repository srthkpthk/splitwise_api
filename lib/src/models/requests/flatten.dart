/// Flattens a list of per-user maps into the `users__{index}__{property}`
/// keys that the Splitwise API expects for `create_expense`, `update_expense`,
/// `create_group` and `create_friends`.
///
/// ```dart
/// flattenUsers([{'user_id': 1, 'paid_share': '5.00'}])
/// // => {'users__0__user_id': 1, 'users__0__paid_share': '5.00'}
/// ```
Map<String, Object?> flattenUsers(Iterable<Map<String, Object?>> users) => {
  for (final (index, user) in users.indexed)
    for (final entry in user.entries)
      'users__${index}__${entry.key}': entry.value,
};
