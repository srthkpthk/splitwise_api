import 'package:http/http.dart' as http;

import 'exceptions.dart';
import 'models/models.dart';
import 'models/requests/flatten.dart';
import 'transport.dart';

/// A client for the Splitwise API v3.0.
///
/// Authenticate with a personal API key generated on your app's page at
/// <https://secure.splitwise.com/apps>:
///
/// ```dart
/// final client = SplitwiseClient.apiKey('YOUR_API_KEY');
/// final me = await client.getCurrentUser();
/// ```
///
/// or with an OAuth 2.0 access token obtained through [SplitwiseOAuth2]:
///
/// ```dart
/// final client = SplitwiseClient.accessToken(token.accessToken);
/// ```
///
/// Every method returns typed models. Failures are reported as exceptions:
/// [SplitwiseHttpException] (and its subclasses) for non-2xx responses and
/// [SplitwiseRequestFailedException] when Splitwise answers 200 but reports
/// `"success": false` or validation `errors`.
///
/// Call [close] when you are done to release the HTTP client.
class SplitwiseClient {
  /// Creates a client authenticated with a personal API key.
  ///
  /// [httpClient] lets you supply your own [http.Client] (for example a
  /// `MockClient` in tests); it will not be closed by [close]. [baseUrl]
  /// overrides [defaultBaseUrl]. [bodyEncoding] selects how `POST` bodies are
  /// encoded.
  SplitwiseClient.apiKey(
    String apiKey, {
    http.Client? httpClient,
    Uri? baseUrl,
    BodyEncoding bodyEncoding = BodyEncoding.json,
  }) : this._(
         apiKey,
         httpClient: httpClient,
         baseUrl: baseUrl,
         bodyEncoding: bodyEncoding,
       );

  /// Creates a client authenticated with an OAuth 2.0 access token.
  ///
  /// See [SplitwiseClient.apiKey] for the parameters.
  SplitwiseClient.accessToken(
    String accessToken, {
    http.Client? httpClient,
    Uri? baseUrl,
    BodyEncoding bodyEncoding = BodyEncoding.json,
  }) : this._(
         accessToken,
         httpClient: httpClient,
         baseUrl: baseUrl,
         bodyEncoding: bodyEncoding,
       );

  SplitwiseClient._(
    String bearerToken, {
    required http.Client? httpClient,
    required Uri? baseUrl,
    required BodyEncoding bodyEncoding,
  }) : _transport = SplitwiseTransport(
         bearerToken: bearerToken,
         baseUrl: baseUrl ?? defaultBaseUrl,
         httpClient: httpClient,
         bodyEncoding: bodyEncoding,
       );

  /// The production API base URL.
  static final Uri defaultBaseUrl = Uri.parse(
    'https://secure.splitwise.com/api/v3.0/',
  );

  final SplitwiseTransport _transport;

  /// Releases the underlying HTTP client if this instance created it.
  void close() => _transport.close();

  // ---------------------------------------------------------------- Users

  /// Returns the authenticated user.
  Future<CurrentUser> getCurrentUser() async {
    final json = await _transport.get('get_current_user');
    return CurrentUser.fromJson(_object(json, 'user'));
  }

  /// Returns the user with [id].
  Future<User> getUser(int id) async {
    final json = await _transport.get('get_user/$id');
    return User.fromJson(_object(json, 'user'));
  }

  /// Updates the user with [id] and returns the updated user.
  Future<User> updateUser(int id, UpdateUserRequest request) async {
    final json = await _transport.post(
      'update_user/$id',
      body: request.toJson(),
    );
    // The spec documents this response unwrapped (a bare user object) while
    // every other endpoint wraps its payload; accept both.
    final user = json['user'];
    return User.fromJson(user is Map<String, dynamic> ? user : json);
  }

  // --------------------------------------------------------------- Groups

  /// Returns every group the current user belongs to.
  ///
  /// Includes the pseudo-group with id `0` that holds expenses outside any
  /// group.
  Future<List<Group>> getGroups() async {
    final json = await _transport.get('get_groups');
    return _list(json, 'groups', Group.fromJson);
  }

  /// Returns the group with [id] (`0` for the non-group pseudo-group).
  Future<Group> getGroup(int id) async {
    final json = await _transport.get('get_group/$id');
    return Group.fromJson(_object(json, 'group'));
  }

  /// Creates a group and returns it.
  Future<Group> createGroup(CreateGroupRequest request) async {
    final json = await _transport.post('create_group', body: request.toJson());
    return Group.fromJson(_object(json, 'group'));
  }

  /// Deletes the group with [id].
  Future<void> deleteGroup(int id) => _transport.post('delete_group/$id');

  /// Restores a deleted group.
  Future<void> undeleteGroup(int id) => _transport.post('undelete_group/$id');

  /// Adds the existing user [userId] to the group [groupId] and returns them.
  Future<User> addUserToGroup({
    required int groupId,
    required int userId,
  }) async {
    final json = await _transport.post(
      'add_user_to_group',
      body: {'group_id': groupId, 'user_id': userId},
    );
    return User.fromJson(_object(json, 'user'));
  }

  /// Adds a user identified by [email] to the group [groupId], creating and
  /// inviting them if they have no Splitwise account, and returns them.
  Future<User> addUserToGroupByEmail({
    required int groupId,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    final json = await _transport.post(
      'add_user_to_group',
      body: {
        'group_id': groupId,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      },
    );
    return User.fromJson(_object(json, 'user'));
  }

  /// Removes the user [userId] from the group [groupId].
  ///
  /// Fails if the user still has a non-zero balance in the group.
  Future<void> removeUserFromGroup({
    required int groupId,
    required int userId,
  }) => _transport.post(
    'remove_user_from_group',
    body: {'group_id': groupId, 'user_id': userId},
  );

  // -------------------------------------------------------------- Friends

  /// Returns the current user's friends.
  Future<List<Friend>> getFriends() async {
    final json = await _transport.get('get_friends');
    return _list(json, 'friends', Friend.fromJson);
  }

  /// Returns the friend with [id].
  Future<Friend> getFriend(int id) async {
    final json = await _transport.get('get_friend/$id');
    return Friend.fromJson(_object(json, 'friend'));
  }

  /// Adds the user with [email] as a friend, creating and inviting them if
  /// they have no Splitwise account.
  Future<Friend> createFriend({
    required String email,
    String? firstName,
    String? lastName,
  }) async {
    final json = await _transport.post(
      'create_friend',
      body: {
        'user_email': email,
        'user_first_name': ?firstName,
        'user_last_name': ?lastName,
      },
    );
    return Friend.fromJson(_object(json, 'friend'));
  }

  /// Adds several users as friends at once.
  ///
  /// This endpoint is always sent form-encoded because Splitwise's server
  /// does not accept a JSON body for it. If Splitwise reports errors for any
  /// entry the whole call throws [SplitwiseRequestFailedException] and any
  /// partial results are discarded.
  Future<List<Friend>> createFriends(List<NewFriend> friends) async {
    final json = await _transport.post(
      'create_friends',
      body: flattenUsers(friends.map((friend) => friend.toJson())),
      encoding: BodyEncoding.formUrlEncoded,
    );
    return _list(json, 'users', Friend.fromJson);
  }

  /// Removes the friendship with the user [id].
  Future<void> deleteFriend(int id) => _transport.post('delete_friend/$id');

  // ------------------------------------------------------------- Expenses

  /// Returns the expense with [id].
  Future<Expense> getExpense(int id) async {
    final json = await _transport.get('get_expense/$id');
    return Expense.fromJson(_object(json, 'expense'));
  }

  /// Returns the current user's expenses, newest first.
  ///
  /// [friendId] is ignored when [groupId] is set. [limit] defaults to 20 on
  /// the server; pass `0` for no limit.
  Future<List<Expense>> getExpenses({
    int? groupId,
    int? friendId,
    DateTime? datedAfter,
    DateTime? datedBefore,
    DateTime? updatedAfter,
    DateTime? updatedBefore,
    int? limit,
    int? offset,
  }) async {
    final json = await _transport.get(
      'get_expenses',
      query: {
        'group_id': groupId?.toString(),
        'friend_id': friendId?.toString(),
        'dated_after': _iso(datedAfter),
        'dated_before': _iso(datedBefore),
        'updated_after': _iso(updatedAfter),
        'updated_before': _iso(updatedBefore),
        'limit': limit?.toString(),
        'offset': offset?.toString(),
      },
    );
    return _list(json, 'expenses', Expense.fromJson);
  }

  /// Creates an expense and returns the resulting expense(s).
  ///
  /// A repeating expense may produce more than one entry.
  Future<List<Expense>> createExpense(CreateExpenseRequest request) async {
    final json = await _transport.post(
      'create_expense',
      body: request.toJson(),
    );
    return _list(json, 'expenses', Expense.fromJson);
  }

  /// Updates the expense with [id] and returns the resulting expense(s).
  Future<List<Expense>> updateExpense(
    int id,
    UpdateExpenseRequest request,
  ) async {
    final json = await _transport.post(
      'update_expense/$id',
      body: request.toJson(),
    );
    return _list(json, 'expenses', Expense.fromJson);
  }

  /// Deletes the expense with [id].
  Future<void> deleteExpense(int id) => _transport.post('delete_expense/$id');

  /// Restores a deleted expense.
  Future<void> undeleteExpense(int id) =>
      _transport.post('undelete_expense/$id');

  // ------------------------------------------------------------- Comments

  /// Returns the comments on the expense [expenseId].
  Future<List<Comment>> getComments({required int expenseId}) async {
    final json = await _transport.get(
      'get_comments',
      query: {'expense_id': expenseId.toString()},
    );
    return _list(json, 'comments', Comment.fromJson);
  }

  /// Adds a comment to the expense [expenseId] and returns it.
  Future<Comment> createComment({
    required int expenseId,
    required String content,
  }) async {
    final json = await _transport.post(
      'create_comment',
      body: {'expense_id': expenseId, 'content': content},
    );
    return Comment.fromJson(_object(json, 'comment'));
  }

  /// Deletes the comment with [id] and returns it.
  Future<Comment> deleteComment(int id) async {
    final json = await _transport.post('delete_comment/$id');
    return Comment.fromJson(_object(json, 'comment'));
  }

  // -------------------------------------------------------- Notifications

  /// Returns the current user's notifications, newest first.
  ///
  /// [limit] defaults to 0 (no limit) on the server.
  Future<List<SplitwiseNotification>> getNotifications({
    DateTime? updatedAfter,
    int? limit,
  }) async {
    final json = await _transport.get(
      'get_notifications',
      query: {'updated_after': _iso(updatedAfter), 'limit': limit?.toString()},
    );
    return _list(json, 'notifications', SplitwiseNotification.fromJson);
  }

  // ---------------------------------------------------------------- Other

  /// Returns the currencies Splitwise supports.
  Future<List<Currency>> getCurrencies() async {
    final json = await _transport.get('get_currencies');
    return _list(json, 'currencies', Currency.fromJson);
  }

  /// Returns the expense categories and their subcategories.
  Future<List<SplitwiseParentCategory>> getCategories() async {
    final json = await _transport.get('get_categories');
    return _list(json, 'categories', SplitwiseParentCategory.fromJson);
  }

  // -------------------------------------------------------------- Helpers

  static String? _iso(DateTime? value) => value?.toUtc().toIso8601String();

  static Map<String, dynamic> _object(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is Map<String, dynamic>) {
      return value;
    }
    throw SplitwiseException(
      'Expected a "$key" object in the response but found '
      '${value == null ? 'nothing' : value.runtimeType}',
    );
  }

  static List<T> _list<T>(
    Map<String, dynamic> json,
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final value = json[key];
    if (value == null) {
      return const [];
    }
    if (value is List) {
      return [for (final item in value) fromJson(item as Map<String, dynamic>)];
    }
    throw SplitwiseException(
      'Expected a "$key" array in the response but found ${value.runtimeType}',
    );
  }
}
