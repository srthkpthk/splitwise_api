import 'package:oauth1/oauth1.dart' as oauth;

import '../../../splitwise_api.dart';

/// The main service class for interacting with the Splitwise API v3.0.
///
/// This class provides a comprehensive wrapper around all Splitwise API endpoints,
/// handling OAuth 1.0 authentication and HTTP communication. It supports full
/// CRUD operations for users, groups, friends, expenses, comments, and more.
///
/// ## Authentication Flow
///
/// 1. Initialize the service with your OAuth credentials:
/// ```dart
/// final service = SplitWiseService.initialize(
///   'your_consumer_key',
///   'your_consumer_secret',
/// );
/// ```
///
/// 2. Get authorization URL and direct user to authorize:
/// ```dart
/// final authUrl = await service.validateClient();
/// // User visits authUrl and gets verifier code
/// ```
///
/// 3. Exchange verifier for access tokens:
/// ```dart
/// final tokens = await service.validateClient(verifier: 'code');
/// // Save tokens for future sessions
/// ```
///
/// 4. For subsequent sessions, restore with saved tokens:
/// ```dart
/// await service.validateClient(tokens: savedTokens);
/// // Now ready to make API calls
/// ```
///
/// ## Usage Example
///
/// ```dart
/// // After authentication...
/// final user = await service.getCurrentUser();
/// final groups = await service.getGroups();
/// final expenses = await service.getExpenses(options: {
///   'dated_after': '2024-01-01T00:00:00Z',
/// });
///
/// await service.createExpense({
///   'cost': '50.00',
///   'description': 'Dinner',
///   'group_id': '12345',
///   'split_equally': 'true',
/// });
/// ```
///
/// ## API Response Format
///
/// Most methods return:
/// * [String] - JSON response on success (parse with `jsonDecode()`)
/// * [int] - HTTP status code on failure
/// * [bool] - Success flag for delete operations
///
/// ## Available API Sections
///
/// * **Users**: [getCurrentUser], [getUser], [updateUser]
/// * **Groups**: [getGroups], [getGroup], [createGroup], [deleteGroup], etc.
/// * **Friends**: [getFriends], [getFriend], [createFriend], [deleteFriend], etc.
/// * **Expenses**: [getExpenses], [getExpense], [createExpense], [updateExpense], etc.
/// * **Comments**: [getComments], [createComment], [deleteComment]
/// * **Notifications**: [getNotifications]
/// * **Utilities**: [getCurrencies], [getCategories], [parseSentence]
///
/// See also:
/// * [Splitwise API Documentation](https://dev.splitwise.com)
/// * [TokensHelper] for token management
class SplitWiseService {
//<editor-fold desc="Method Utils">

  /// This Method is used to call the GET  method at SplitWise API path is the path for SplitWise API 4
  /// and options are the map for queries
  Future<dynamic> _makeGetRequest(String path, {Map<String, String>? options}) async {
    if (_client == null) {
      throw Exception('Please use validateClient First');
    } else {
      var t = await _client!
          .get(Uri.https('secure.splitwise.com', '/api/v3.0/$path', options));
      print(t.body);
      return t.statusCode == 200 ? t.body : t.statusCode;
    }
  }

  /// This Method is used to call the POST method at SplitWise API path is the path for SplitWise API
  /// and options are the map for queries
  Future<dynamic> _makePostRequest(String path, {Map<String, String>? options}) async {
    if (_client == null) {
      throw Exception('Please use validateClient First');
    } else {
      var t = await _client!
          .post(Uri.https('secure.splitwise.com', '/api/v3.0/$path', options));
      print(t.body);
      return t.statusCode == 200 ? t.body : t.statusCode;
    }
  }

//</editor-fold> {

//<editor-fold desc="Authorization Section">

  /// This is used to set the platform
  oauth.Platform _platform = oauth.Platform(
      'https://secure.splitwise.com/oauth/request_token',
      'https://secure.splitwise.com/oauth/authorize',
      'https://secure.splitwise.com/oauth/access_token',
      oauth.SignatureMethods.hmacSha1);

  oauth.ClientCredentials? _clientCredentials;
  oauth.Authorization? _auth;
  oauth.Client? _client;
  oauth.AuthorizationResponse? url;

  /// Initializes the SplitWise service with OAuth 1.0 credentials.
  ///
  /// This factory constructor sets up the authentication infrastructure required
  /// for making authenticated API requests to Splitwise. You must call this
  /// constructor before using any other methods in this service.
  ///
  /// The credentials can be obtained by registering your application at:
  /// https://secure.splitwise.com/apps
  ///
  /// Example:
  /// ```dart
  /// final service = SplitWiseService.initialize(
  ///   'your_consumer_key',
  ///   'your_consumer_secret',
  /// );
  /// ```
  ///
  /// Parameters:
  /// * [_consumerKey] - The consumer key from your Splitwise app registration
  /// * [_consumerSecret] - The consumer secret from your Splitwise app registration
  ///
  /// See also:
  /// * [validateClient] for completing the OAuth flow
  SplitWiseService.initialize(String _consumerKey, String _consumerSecret) {
    _clientCredentials = oauth.ClientCredentials(_consumerKey, _consumerSecret);
    _auth = oauth.Authorization(_clientCredentials!, _platform);
  }

  /// Manages the OAuth 1.0 authentication flow for Splitwise API access.
  ///
  /// This versatile method handles three distinct authentication scenarios based
  /// on the provided parameters:
  ///
  /// **Scenario 1: Get Authorization URL** (no parameters)
  /// ```dart
  /// final authUrl = await service.validateClient();
  /// // Direct user to authUrl to authorize your app
  /// ```
  ///
  /// **Scenario 2: Exchange Verifier for Tokens** (verifier parameter)
  /// ```dart
  /// final tokens = await service.validateClient(verifier: 'user_verifier_code');
  /// // Save tokens.token and tokens.tokenSecret for future use
  /// ```
  ///
  /// **Scenario 3: Restore Session with Saved Tokens** (tokens parameter)
  /// ```dart
  /// final savedTokens = TokensHelper(token, tokenSecret);
  /// await service.validateClient(tokens: savedTokens);
  /// // Client is now ready to make authenticated requests
  /// ```
  ///
  /// Parameters:
  /// * [verifier] - The OAuth verifier code provided by the user after authorization
  /// * [tokens] - Previously saved OAuth tokens to restore an existing session
  ///
  /// Returns:
  /// * [String] - Authorization URL (Scenario 1)
  /// * [TokensHelper] - OAuth tokens to save (Scenario 2)
  /// * [oauth.Client] - Configured HTTP client (Scenario 3)
  ///
  /// Throws:
  /// * [Exception] if OAuth flow fails at any step
  ///
  /// Important:
  /// * You must save the tokens returned in Scenario 2 for persistent authentication
  /// * After Scenario 2 or 3, the client is ready for API calls
  ///
  /// See also:
  /// * [TokensHelper] for token storage utilities
  Future<dynamic> validateClient({String? verifier, TokensHelper? tokens}) async {
    if (verifier == null && tokens == null) {
      url = await _auth!.requestTemporaryCredentials('oob');
      return _auth!.getResourceOwnerAuthorizationURI(url!.credentials.token);
    } else if ((verifier != null && verifier.isNotEmpty) && tokens == null) {
      var cred =
          await _auth!.requestTokenCredentials(url!.credentials, verifier);
      print(cred.credentials);
      print(
          'Save these both to SharedPrefs or any where these are required for keep signed in ');
      _client = oauth.Client(oauth.SignatureMethods.hmacSha1,
          _clientCredentials!, cred.credentials);
      return TokensHelper(cred.credentials.token, cred.credentials.tokenSecret);
    } else {
      _client = oauth.Client(
          oauth.SignatureMethods.hmacSha1,
          _clientCredentials!,
          oauth.Credentials(tokens!.token!, tokens.tokenSecret!));
      return _client;
    }
  }

//</editor-fold>

//<editor-fold desc="User Section">
  /// Retrieves the current authenticated user's profile information.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_current_user`
  ///
  /// Returns comprehensive user profile data including:
  /// * User ID, first name, last name, email
  /// * Registration status and date
  /// * Profile picture URLs (small, medium, large)
  /// * Default currency and locale settings
  /// * Notification preferences
  /// * Date format preferences
  ///
  /// Example:
  /// ```dart
  /// final userJson = await service.getCurrentUser();
  /// final user = jsonDecode(userJson);
  /// print('Hello, ${user['first_name']} ${user['last_name']}!');
  /// print('Email: ${user['email']}');
  /// ```
  ///
  /// Returns:
  /// * [String] - JSON response containing user data on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getUser] for fetching other user profiles by ID
  /// * [updateUser] for modifying user information
  Future<dynamic> getCurrentUser() async =>
      await _makeGetRequest('get_current_user', options: {});

  /// Retrieves profile information for a specific user by ID.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_user/{id}`
  ///
  /// Returns user profile data including:
  /// * User ID, name, email
  /// * Profile picture URLs
  /// * Registration date
  /// * Balance information with the current user (if applicable)
  ///
  /// Example:
  /// ```dart
  /// final friendJson = await service.getUser(12345);
  /// final friend = jsonDecode(friendJson);
  /// print('Friend: ${friend['first_name']}');
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the user to retrieve
  ///
  /// Returns:
  /// * [String] - JSON response containing user data on success
  /// * [int] - HTTP status code on failure (e.g., 404 if user not found)
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getCurrentUser] for fetching the authenticated user's profile
  /// * [updateUser] for modifying user information
  Future<dynamic> getUser(int id) async => await _makeGetRequest('get_user/$id');

  /// Updates profile information for a specific user.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/update_user/{id}`
  ///
  /// Allows modification of user profile fields such as:
  /// * first_name, last_name
  /// * email
  /// * default_currency
  /// * locale, date_format
  /// * notification_settings
  ///
  /// Example:
  /// ```dart
  /// final result = await service.updateUser(12345, {
  ///   'first_name': 'John',
  ///   'default_currency': 'USD',
  ///   'locale': 'en',
  /// });
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the user to update
  /// * [options] - Map of field names to values for updating user profile
  ///
  /// Returns:
  /// * [String] - JSON response with updated user data on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// Note: Users can only update their own profile information
  ///
  /// See also:
  /// * [getCurrentUser] for retrieving current user information
  /// * [getUser] for fetching user profiles
  Future<dynamic> updateUser(int id, Map<String, String> options) async =>
      await _makePostRequest('https://www.splitwise.comupdate_user/$id',
          options: options);

//</editor-fold>

//<editor-fold desc="Group Section">
  /// Retrieves all groups the current user belongs to.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_groups`
  ///
  /// Returns a list of all groups including:
  /// * Group ID, name, and type (apartment, house, trip, etc.)
  /// * Group members and their balances
  /// * Simplified debts within the group
  /// * Group avatar/cover image
  /// * Invite link
  ///
  /// Example:
  /// ```dart
  /// final groupsJson = await service.getGroups();
  /// final groupsData = jsonDecode(groupsJson);
  /// for (var group in groupsData['groups']) {
  ///   print('Group: ${group['name']}');
  /// }
  /// ```
  ///
  /// Returns:
  /// * [String] - JSON response containing array of groups on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getGroup] for fetching detailed information about a specific group
  /// * [createGroup] for creating a new group
  Future<dynamic> getGroups() async => await _makeGetRequest('get_groups');

  /// Retrieves detailed information about a specific group.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_group/{id}`
  ///
  /// Returns comprehensive group information including:
  /// * Group name, type, creation date
  /// * All group members with their balances
  /// * Original debts and simplified debts
  /// * Group avatar and cover image
  /// * Invite link and group settings
  ///
  /// Example:
  /// ```dart
  /// final groupJson = await service.getGroup(98765);
  /// final group = jsonDecode(groupJson);
  /// print('Group: ${group['name']}');
  /// print('Members: ${group['members'].length}');
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the group to retrieve
  ///
  /// Returns:
  /// * [String] - JSON response containing detailed group data on success
  /// * [int] - HTTP status code on failure (e.g., 404 if group not found)
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getGroups] for fetching all groups
  /// * [createGroup] for creating a new group
  Future<dynamic> getGroup(int id) async => await _makeGetRequest('get_group/$id');

  /// Creates a new group on Splitwise.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/create_group`
  ///
  /// Required fields in options:
  /// * `name` - The name of the group
  ///
  /// Optional fields:
  /// * `group_type` - Type of group (apartment, house, trip, other, etc.)
  /// * `simplify_by_default` - Whether to simplify debts by default (true/false)
  /// * `users__[n]__user_id` - User IDs to add as members
  /// * `users__[n]__first_name` - First name if user_id not known
  /// * `users__[n]__last_name` - Last name if user_id not known
  /// * `users__[n]__email` - Email if user_id not known
  ///
  /// Example:
  /// ```dart
  /// final result = await service.createGroup({
  ///   'name': 'Vacation 2024',
  ///   'group_type': 'trip',
  ///   'simplify_by_default': 'true',
  ///   'users__0__user_id': '12345',
  ///   'users__1__email': 'friend@example.com',
  /// });
  /// ```
  ///
  /// Parameters:
  /// * [options] - Map containing group details and member information
  ///
  /// Returns:
  /// * [String] - JSON response with created group data on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getGroup] for retrieving group information
  /// * [addUserToGroup] for adding members after creation
  Future<dynamic> createGroup(Map<String, String> options) async =>
      await _makePostRequest('create_group', options: options);

  /// Deletes (archives) a group from Splitwise.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/delete_group/{id}`
  ///
  /// Note: This doesn't permanently delete the group, it archives it.
  /// The group can be restored using [unDeleteGroup].
  /// Only group creators or admins can delete groups.
  ///
  /// Example:
  /// ```dart
  /// final result = await service.deleteGroup(98765);
  /// if (result == true) {
  ///   print('Group archived successfully');
  /// } else {
  ///   print('Error: $result');
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the group to delete
  ///
  /// Returns:
  /// * [bool] - `true` if deletion was successful
  /// * [dynamic] - Error details if deletion failed
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [unDeleteGroup] for restoring a deleted group
  /// * [getGroups] for retrieving all groups
  Future<dynamic> deleteGroup(int id) async {
    var t = await _makePostRequest('delete_group/$id');
    return t.success! ? true : t.errors;
  }

  /// Restores a previously deleted (archived) group.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/undelete_group/{id}`
  ///
  /// Restores a group that was previously archived using [deleteGroup].
  /// Only the group creator or admin can restore groups.
  ///
  /// Example:
  /// ```dart
  /// final result = await service.unDeleteGroup(98765);
  /// if (result == true) {
  ///   print('Group restored successfully');
  /// } else {
  ///   print('Error: $result');
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the group to restore
  ///
  /// Returns:
  /// * [bool] - `true` if restoration was successful
  /// * [dynamic] - Error details if restoration failed
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [deleteGroup] for archiving a group
  /// * [getGroup] for retrieving group information
  Future<dynamic> unDeleteGroup(int id) async {
    var t = await _makePostRequest('undelete_group/$id');
    return t.success! ? true : t.errors;
  }

  /// Adds a new member to an existing group.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/add_user_to_group`
  ///
  /// Required fields in options:
  /// * `group_id` - The ID of the group to add the user to
  /// * Either `user_id` OR `first_name`, `last_name`, and `email`
  ///
  /// Example with existing user:
  /// ```dart
  /// final result = await service.addUserToGroup({
  ///   'group_id': '98765',
  ///   'user_id': '12345',
  /// });
  /// ```
  ///
  /// Example with new user:
  /// ```dart
  /// final result = await service.addUserToGroup({
  ///   'group_id': '98765',
  ///   'first_name': 'John',
  ///   'last_name': 'Doe',
  ///   'email': 'john@example.com',
  /// });
  /// ```
  ///
  /// Parameters:
  /// * [options] - Map containing group_id and user identification details
  ///
  /// Returns:
  /// * [bool] - `true` if user was added successfully
  /// * [dynamic] - Error details if addition failed
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [removeUserFromGroup] for removing a user from a group
  /// * [createGroup] for creating a group with initial members
  Future<dynamic> addUserToGroup(Map<String, String> options) async {
    var t = await _makePostRequest('add_user_to_group');
    return t.success! ? true : t.errors;
  }

  /// Removes a member from a group.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/remove_user_from_group`
  ///
  /// Required fields in options:
  /// * `group_id` - The ID of the group to remove the user from
  /// * `user_id` - The ID of the user to remove
  ///
  /// Note: Users with outstanding balances in the group may need to
  /// settle their debts before being removed.
  ///
  /// Example:
  /// ```dart
  /// final result = await service.removeUserFromGroup({
  ///   'group_id': 98765,
  ///   'user_id': 12345,
  /// });
  /// if (result == true) {
  ///   print('User removed successfully');
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [options] - Map containing group_id and user_id
  ///
  /// Returns:
  /// * [bool] - `true` if user was removed successfully
  /// * [dynamic] - Error details if removal failed
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [addUserToGroup] for adding a user to a group
  /// * [deleteGroup] for archiving the entire group
  Future<dynamic> removeUserFromGroup(Map<String, int> options) async {
    var t = await _makePostRequest('remove_user_from_group');
    return t.success! ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Friends Section">

  /// Retrieves all friends of the current user.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_friends`
  ///
  /// Returns a list of all friends including:
  /// * Friend ID, name, email
  /// * Profile picture
  /// * Balance information (what they owe you or you owe them)
  /// * Groups shared with the friend
  ///
  /// Example:
  /// ```dart
  /// final friendsJson = await service.getFriends();
  /// final friendsData = jsonDecode(friendsJson);
  /// for (var friend in friendsData['friends']) {
  ///   print('${friend['first_name']}: ${friend['balance']}');
  /// }
  /// ```
  ///
  /// Returns:
  /// * [String] - JSON response containing array of friends on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getFriend] for fetching a specific friend's details
  /// * [createFriend] for adding a new friend
  Future<dynamic> getFriends() async => await _makeGetRequest('get_friends');

  /// Retrieves detailed information about a specific friend.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_friend/{id}`
  ///
  /// Returns detailed friend information including:
  /// * Friend's profile details
  /// * Complete balance breakdown by group
  /// * Shared groups
  /// * Recent activity
  ///
  /// Example:
  /// ```dart
  /// final friendJson = await service.getFriend(12345);
  /// final friend = jsonDecode(friendJson);
  /// print('${friend['first_name']} owes you: ${friend['balance']}');
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the friend to retrieve
  ///
  /// Returns:
  /// * [String] - JSON response containing friend data on success
  /// * [int] - HTTP status code on failure (e.g., 404 if friend not found)
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getFriends] for fetching all friends
  /// * [deleteFriend] for removing a friend
  Future<dynamic> getFriend(int id) async => await _makeGetRequest('get_friend/$id');

  /// Adds a new friend on Splitwise.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/create_friend`
  ///
  /// Required fields in options (one of):
  /// * `user_id` - ID of an existing Splitwise user
  /// * `user_email` - Email address to add friend by email
  /// * Both `user_first_name` and `user_last_name` - Name-based friend add
  ///
  /// Example with existing user:
  /// ```dart
  /// final result = await service.createFriend({
  ///   'user_id': '12345',
  /// });
  /// ```
  ///
  /// Example with email:
  /// ```dart
  /// final result = await service.createFriend({
  ///   'user_email': 'friend@example.com',
  ///   'user_first_name': 'John',
  ///   'user_last_name': 'Doe',
  /// });
  /// ```
  ///
  /// Parameters:
  /// * [options] - Map containing friend identification details
  ///
  /// Returns:
  /// * [String] - JSON response with created friend data on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [createFriends] for adding multiple friends at once
  /// * [getFriends] for retrieving all friends
  Future<dynamic> createFriend(Map<String, String> options) async =>
      await _makePostRequest('create_friend', options: options);

  /// Adds multiple friends on Splitwise in a single request.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/create_friends`
  ///
  /// Use indexed notation for multiple friends:
  /// * `friends__[n]__user_id` - ID of existing user
  /// * `friends__[n]__user_email` - Email address
  /// * `friends__[n]__user_first_name` and `friends__[n]__user_last_name`
  ///
  /// Example:
  /// ```dart
  /// final result = await service.createFriends({
  ///   'friends__0__user_email': 'alice@example.com',
  ///   'friends__0__user_first_name': 'Alice',
  ///   'friends__0__user_last_name': 'Smith',
  ///   'friends__1__user_id': '12345',
  ///   'friends__2__user_email': 'bob@example.com',
  /// });
  /// ```
  ///
  /// Parameters:
  /// * [options] - Map containing multiple friend details with indexed keys
  ///
  /// Returns:
  /// * [String] - JSON response with created friends data on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [createFriend] for adding a single friend
  /// * [getFriends] for retrieving all friends
  Future<dynamic> createFriends(Map<String, String> options) async =>
      await _makePostRequest('create_friends', options: options);

  /// Removes a friend from your Splitwise account.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/delete_friend/{id}`
  ///
  /// Note: This only removes the friend connection. Any shared expenses
  /// and balances will remain unless separately settled or deleted.
  ///
  /// Example:
  /// ```dart
  /// final result = await service.deleteFriend(12345);
  /// if (result == true) {
  ///   print('Friend removed successfully');
  /// } else {
  ///   print('Error: $result');
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the friend to remove
  ///
  /// Returns:
  /// * [bool] - `true` if friend was removed successfully
  /// * [dynamic] - Error details if removal failed
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [createFriend] for adding a friend
  /// * [getFriends] for retrieving all friends
  Future<dynamic> deleteFriend(int id) async {
    var t = await _makePostRequest('delete_friend/$id');
    return t.success! ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Expenses Section">

  /// Retrieves detailed information about a specific expense.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_expense/{id}`
  ///
  /// Returns comprehensive expense information including:
  /// * Expense amount, currency, description, date
  /// * Category and subcategory
  /// * Group or friend association
  /// * How the expense is split (equal, exact, percentage, shares)
  /// * Payment status
  /// * Receipt images
  /// * Creation and update timestamps
  ///
  /// Example:
  /// ```dart
  /// final expenseJson = await service.getExpense(54321);
  /// final expense = jsonDecode(expenseJson);
  /// print('${expense['description']}: ${expense['cost']}');
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the expense to retrieve
  ///
  /// Returns:
  /// * [String] - JSON response containing expense data on success
  /// * [int] - HTTP status code on failure (e.g., 404 if expense not found)
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getExpenses] for retrieving multiple expenses with filters
  /// * [createExpense] for creating a new expense
  Future<dynamic> getExpense(int id) async => await _makeGetRequest('get_expense/$id');

  /// Retrieves expenses with optional filtering and pagination.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_expenses`
  ///
  /// Optional filter parameters in options:
  /// * `group_id` - Limit to expenses in a specific group
  /// * `friendship_id` - Limit to expenses with a specific friend
  /// * `dated_after` - ISO8601 date (expenses after this date)
  /// * `dated_before` - ISO8601 date (expenses before this date)
  /// * `updated_after` - ISO8601 timestamp (expenses updated after this time)
  /// * `updated_before` - ISO8601 timestamp (expenses updated before this time)
  /// * `limit` - Maximum number of expenses to return (default 20)
  /// * `offset` - Number of expenses to skip (for pagination)
  ///
  /// Example:
  /// ```dart
  /// final expensesJson = await service.getExpenses(options: {
  ///   'group_id': '98765',
  ///   'limit': '50',
  ///   'dated_after': '2024-01-01T00:00:00Z',
  /// });
  /// final expenses = jsonDecode(expensesJson);
  /// ```
  ///
  /// Parameters:
  /// * [options] - Optional map of filter and pagination parameters
  ///
  /// Returns:
  /// * [String] - JSON response containing array of expenses on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [getExpense] for retrieving a single expense
  /// * [createExpense] for creating a new expense
  Future<dynamic> getExpenses({Map<String, String>? options}) async =>
      await _makeGetRequest('get_expenses', options: options);

  /// Creates a new expense on Splitwise.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/create_expense`
  ///
  /// Required fields in options:
  /// * `cost` - The total cost of the expense
  /// * `description` - Brief description of the expense
  ///
  /// Important optional fields:
  /// * `group_id` - Group to add expense to (required if not using users)
  /// * `friendship_id` - Friend to split with (alternative to group_id)
  /// * `date` - Date of expense (ISO8601 format, defaults to today)
  /// * `currency_code` - Three-letter currency code (e.g., USD, EUR)
  /// * `category_id` - Expense category ID
  /// * `payment` - Set to 'true' if this is a payment/settlement
  /// * `users__[n]__user_id` - User IDs involved in the expense
  /// * `users__[n]__paid_share` - Amount each user paid
  /// * `users__[n]__owed_share` - Amount each user owes
  /// * `split_equally` - Set to 'true' to split equally among users
  ///
  /// Example (split equally):
  /// ```dart
  /// await service.createExpense({
  ///   'cost': '50.00',
  ///   'description': 'Dinner',
  ///   'group_id': '98765',
  ///   'currency_code': 'USD',
  ///   'split_equally': 'true',
  /// });
  /// ```
  ///
  /// Example (custom split):
  /// ```dart
  /// await service.createExpense({
  ///   'cost': '60.00',
  ///   'description': 'Groceries',
  ///   'group_id': '98765',
  ///   'users__0__user_id': '12345',
  ///   'users__0__paid_share': '60.00',
  ///   'users__0__owed_share': '30.00',
  ///   'users__1__user_id': '67890',
  ///   'users__1__paid_share': '0.00',
  ///   'users__1__owed_share': '30.00',
  /// });
  /// ```
  ///
  /// Parameters:
  /// * [options] - Map containing expense details and split information
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  /// * [Exception] if required fields are missing
  ///
  /// See also:
  /// * [updateExpense] for modifying an existing expense
  /// * [getExpenses] for retrieving expenses
  Future<void> createExpense(Map<String, String> options) async {
    await _makePostRequest('create_expense', options: options);
  }

  /// Updates an existing expense on Splitwise.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/update_expense/{id}`
  ///
  /// You can update any of the fields used in [createExpense]:
  /// * `cost`, `description`, `date`
  /// * `currency_code`, `category_id`
  /// * User shares and payment splits
  ///
  /// Note: You must provide ALL user share information when updating splits,
  /// not just the users you want to change.
  ///
  /// Example:
  /// ```dart
  /// final result = await service.updateExpense(54321, {
  ///   'cost': '55.00',
  ///   'description': 'Dinner (updated)',
  /// });
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the expense to update
  /// * [options] - Map containing fields to update
  ///
  /// Returns:
  /// * [String] - JSON response with updated expense data on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [createExpense] for creating a new expense
  /// * [deleteExpense] for removing an expense
  Future<dynamic> updateExpense(int id, Map<String, String> options) async =>
      await _makePostRequest('update_expense/$id', options: options);

  /// Deletes an expense from Splitwise.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/delete_expense/{id}`
  ///
  /// Note: Deleted expenses can be restored using [unDeleteExpense].
  /// Only the expense creator can delete an expense.
  ///
  /// Example:
  /// ```dart
  /// final result = await service.deleteExpense(54321);
  /// if (result == true) {
  ///   print('Expense deleted successfully');
  /// } else {
  ///   print('Error: $result');
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the expense to delete
  ///
  /// Returns:
  /// * [bool] - `true` if deletion was successful
  /// * [dynamic] - Error details if deletion failed
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [unDeleteExpense] for restoring a deleted expense
  /// * [updateExpense] for modifying an expense
  Future<dynamic> deleteExpense(int id) async {
    var t = await _makePostRequest('delete_expense/$id');
    return t.success! ? true : t.errors;
  }

  /// Restores a previously deleted expense.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/undelete_expense/{id}`
  ///
  /// Restores an expense that was previously deleted using [deleteExpense].
  /// Only the expense creator can restore an expense.
  ///
  /// Example:
  /// ```dart
  /// final result = await service.unDeleteExpense(54321);
  /// if (result == true) {
  ///   print('Expense restored successfully');
  /// } else {
  ///   print('Error: $result');
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the expense to restore
  ///
  /// Returns:
  /// * [bool] - `true` if restoration was successful
  /// * [dynamic] - Error details if restoration failed
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [deleteExpense] for deleting an expense
  /// * [getExpense] for retrieving expense information
  Future<dynamic> unDeleteExpense(int id) async {
    var t = await _makePostRequest('undelete_expense/$id');
    return t.success! ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Comments Section">

  /// Retrieves all comments for a specific expense.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_comments`
  ///
  /// Returns a list of comments including:
  /// * Comment ID, content, creation date
  /// * User who posted the comment
  /// * Comment type (System or User)
  /// * Relation information (expense, payment, etc.)
  ///
  /// Example:
  /// ```dart
  /// final commentsJson = await service.getComments(54321);
  /// final commentsData = jsonDecode(commentsJson);
  /// for (var comment in commentsData['comments']) {
  ///   print('${comment['user']['first_name']}: ${comment['content']}');
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the expense to get comments for
  ///
  /// Returns:
  /// * [String] - JSON response containing array of comments on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [createComment] for adding a new comment
  /// * [deleteComment] for removing a comment
  Future<dynamic> getComments(int id) async =>
      await _makeGetRequest('get_comments', options: {'expense_id': '$id'});

  /// Adds a comment to an expense.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/create_comment`
  ///
  /// Required fields in options:
  /// * `expense_id` - The ID of the expense to comment on
  /// * `content` - The text content of the comment
  ///
  /// Example:
  /// ```dart
  /// final result = await service.createComment({
  ///   'expense_id': '54321',
  ///   'content': 'Thanks for splitting this!',
  /// });
  /// ```
  ///
  /// Parameters:
  /// * [options] - Map containing expense_id and comment content
  ///
  /// Returns:
  /// * [String] - JSON response with created comment data on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// Note: Comments help track discussions and clarifications about expenses
  ///
  /// See also:
  /// * [getComments] for retrieving comments
  /// * [deleteComment] for removing a comment
  Future<dynamic> createComment(Map<String, String> options) async =>
      _makePostRequest('create_comment', options: options);

  /// Deletes a comment from an expense.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/delete_comment/{id}`
  ///
  /// Note: Only the comment author can delete their own comments.
  ///
  /// Example:
  /// ```dart
  /// final result = await service.deleteComment(98765);
  /// ```
  ///
  /// Parameters:
  /// * [id] - The unique identifier of the comment to delete
  ///
  /// Returns:
  /// * [String] - JSON response confirming deletion on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// See also:
  /// * [createComment] for adding a comment
  /// * [getComments] for retrieving comments
  Future<dynamic> deleteComment(int id) async => _makePostRequest('delete_comment/$id');

//</editor-fold>

//<editor-fold desc="Notification Section">

  /// Retrieves notifications for the current user with optional filtering.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_notifications`
  ///
  /// Optional filter parameters in options:
  /// * `updated_after` - ISO8601 timestamp (notifications after this time)
  /// * `limit` - Maximum number of notifications to return
  ///
  /// Returns notifications about:
  /// * New expenses added
  /// * Expenses updated or deleted
  /// * Comments on expenses
  /// * Friend requests
  /// * Group invitations
  /// * Payment reminders
  ///
  /// Example:
  /// ```dart
  /// final notificationsJson = await service.getNotifications(options: {
  ///   'limit': '20',
  ///   'updated_after': '2024-01-01T00:00:00Z',
  /// });
  /// final notifications = jsonDecode(notificationsJson);
  /// ```
  ///
  /// Parameters:
  /// * [options] - Optional map of filter parameters
  ///
  /// Returns:
  /// * [String] - JSON response containing array of notifications on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// Note: Notifications are returned in reverse chronological order (newest first)
  Future<dynamic> getNotifications({Map<String, String>? options}) async =>
      await _makeGetRequest('get_notifications', options: options);

//</editor-fold>

//<editor-fold desc="Currencies Section">

  /// Retrieves a list of all currencies supported by Splitwise.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_currencies`
  ///
  /// Returns information for each currency including:
  /// * Currency code (e.g., USD, EUR, GBP)
  /// * Currency unit (e.g., $, €, £)
  ///
  /// Example:
  /// ```dart
  /// final currenciesJson = await service.getCurrencies();
  /// final currencies = jsonDecode(currenciesJson);
  /// for (var currency in currencies['currencies']) {
  ///   print('${currency['code']}: ${currency['unit']}');
  /// }
  /// ```
  ///
  /// Returns:
  /// * [String] - JSON response containing array of supported currencies on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// Note: This is useful for providing currency selection in your UI
  ///
  /// See also:
  /// * [createExpense] for creating expenses with specific currencies
  Future<dynamic> getCurrencies() async => _makeGetRequest('get_currencies');

  /// Retrieves a list of all expense categories and subcategories.
  ///
  /// This method calls the Splitwise API endpoint: `GET /api/v3.0/get_categories`
  ///
  /// Returns hierarchical category information including:
  /// * Category ID and name
  /// * Category icon
  /// * Subcategories with their IDs and names
  ///
  /// Common categories include:
  /// * Entertainment, Food and drink, Home
  /// * Transportation, Utilities, General
  /// * And many more with specific subcategories
  ///
  /// Example:
  /// ```dart
  /// final categoriesJson = await service.getCategories();
  /// final categories = jsonDecode(categoriesJson);
  /// for (var category in categories['categories']) {
  ///   print('${category['name']}: ${category['subcategories'].length} subcategories');
  /// }
  /// ```
  ///
  /// Returns:
  /// * [String] - JSON response containing array of categories on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// Note: Use category IDs when creating or updating expenses
  ///
  /// See also:
  /// * [createExpense] for creating expenses with categories
  Future<dynamic> getCategories() async => await _makeGetRequest('get_categories');

  /// Parses a natural language sentence into expense details.
  ///
  /// This method calls the Splitwise API endpoint: `POST /api/v3.0/parse_sentence`
  ///
  /// Splitwise's AI will attempt to extract expense information from
  /// natural language input, including:
  /// * Amount and currency
  /// * Description
  /// * Category
  /// * Date
  ///
  /// Required fields in options:
  /// * `input` - The natural language sentence to parse
  /// * `friend_id` OR `group_id` - Context for the expense
  ///
  /// Example:
  /// ```dart
  /// final result = await service.parseSentence({
  ///   'input': 'Paid $50 for dinner last night',
  ///   'group_id': '98765',
  /// });
  /// final parsed = jsonDecode(result);
  /// print('Amount: ${parsed['cost']}');
  /// print('Description: ${parsed['description']}');
  /// ```
  ///
  /// Parameters:
  /// * [options] - Map containing the sentence to parse and context
  ///
  /// Returns:
  /// * [String] - JSON response with parsed expense details on success
  /// * [int] - HTTP status code on failure
  ///
  /// Throws:
  /// * [Exception] if client is not initialized via [validateClient]
  ///
  /// Note: This is a convenience feature for quick expense entry
  ///
  /// See also:
  /// * [createExpense] for creating expenses with the parsed data
  Future<dynamic> parseSentence(Map<String, String> options) async =>
      _makePostRequest('parse_sentence', options: options);

//</editor-fold>
}
