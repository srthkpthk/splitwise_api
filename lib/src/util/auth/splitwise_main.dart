import 'dart:convert';

import 'package:oauth1/oauth1.dart' as oauth;
import 'package:splitwise_api/src/util/data/model/expenses_entity.dart';
import 'package:splitwise_api/src/util/data/model/post_expense.dart';

import '../../../splitwise_api.dart';

class SplitWiseService {
//<editor-fold desc="Method Utils">

  /// This Method is used to call the GET  method at SplitWise API path is the path for SplitWise API 4
  /// and options are the map for queries
  _makeGetRequest(String path, {Map<String, String> options}) async {
    if (_client == null) {
      throw Exception('Please use validateClient First');
    } else {
      var t = await _client
          .get(Uri.https('secure.splitwise.com', '/api/v3.0/$path', options));
      return t.statusCode == 200 ? t.body : t.statusCode;
    }
  }

  /// This Method is used to call the POST method at SplitWise API path is the path for SplitWise API
  /// and options are the map for queries
  _makePostRequest(String path, {Map<String, String> options}) async {
    if (_client == null) {
      throw Exception('Please use validateClient First');
    } else {
      var t = await _client
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

  oauth.ClientCredentials _clientCredentials;
  oauth.Authorization _auth;
  oauth.Client _client;
  oauth.AuthorizationResponse url;

  /// This Constructor is used for initializing the _auth and _clientCredentials and takes _consumerKey and _consumerSecret
  SplitWiseService.initialize(String _consumerKey, String _consumerSecret) {
    _clientCredentials = oauth.ClientCredentials(_consumerKey, _consumerSecret);
    _auth = oauth.Authorization(_clientCredentials, _platform);
  }

  ///  This Method i don't know why i created but it has 3 outputs and 3 inputs
  /// 1. It takes nothing then gives out th e authorization URL to authorize
  /// 2. It takes in the verifier from the authorization URL verifier is given by the user
  /// 3. It takes in the token and tokenSecret and validates the _client
  /// Now the _client is ready to use
  validateClient({String verifier, TokensHelper tokens}) async {
    if (verifier == null && tokens == null) {
      url = await _auth.requestTemporaryCredentials('oob');
      return _auth.getResourceOwnerAuthorizationURI(url.credentials.token);
    } else if ((verifier != null && verifier.isNotEmpty) && tokens == null) {
      var cred = await _auth.requestTokenCredentials(url.credentials, verifier);
      print(cred.credentials);
      print(
          'Save these both to SharedPrefs or any where these are required for keep signed in ');
      _client = oauth.Client(oauth.SignatureMethods.hmacSha1,
          _clientCredentials, cred.credentials);
      return TokensHelper(cred.credentials.token, cred.credentials.tokenSecret);
    } else {
      _client = oauth.Client(
          oauth.SignatureMethods.hmacSha1,
          _clientCredentials,
          oauth.Credentials(tokens.token, tokens.tokenSecret));
      return _client;
    }
  }

//</editor-fold>

//<editor-fold desc="User Section">
  ///This Method is used to get the current user's Information
  getCurrentUser() async => CurrentUserEntity.fromJson(
      json.decode(await _makeGetRequest('get_current_user')));

  ///This Method is used to get the Single user Information
  getUser(int id) async => SingleUserEntity.fromJson(
      json.decode(await _makeGetRequest('get_user/$id')));

  ///This Method is used to change the User Information
  updateUser(int id, Map<String, String> options) async =>
      CurrentUserEntity.fromJson(json.decode(await _makePostRequest(
          'https://www.splitwise.comupdate_user/$id',
          options: options)));

//</editor-fold>

//<editor-fold desc="Group Section">
  /// This Method is used to get Groups info
  getGroups() async =>
      GroupsEntity.fromJson(json.decode(await _makeGetRequest('get_groups')));

  /// This method is used to get the info of a single group it takes group_id as input
  getGroup(int id) async =>
      GroupEntity.fromJson(json.decode(await _makeGetRequest('get_group/$id')));

  /// This method is used to create Group
  createGroup(Map<String, String> options) async => GroupEntity.fromJson(
      json.decode(await _makePostRequest('create_group', options: options)));

  /// This method is used to delete Group
  deleteGroup(int id) async {
    var t = PostResponse.fromJson(
        json.decode(await _makePostRequest('delete_group/$id')));
    return t.success ? true : t.errors;
  }

  /// This method is used to un-delete Group
  unDeleteGroup(int id) async {
    var t = PostResponse.fromJson(
        json.decode(await _makePostRequest('undelete_group/$id')));
    return t.success ? true : t.errors;
  }

  /// This method is used to add user to Group
  addUserToGroup(Map<String, String> options) async {
    var t = PostResponse.fromJson(
        json.decode(await _makePostRequest('add_user_to_group')));
    return t.success ? true : t.errors;
  }

  /// This method is used to remove a user from Group
  removeUserFromGroup(Map<String, int> options) async {
    var t = PostResponse.fromJson(
        json.decode(await _makePostRequest('remove_user_from_group')));
    return t.success ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Friends Section">

  /// This method is used to get Friends of the current user
  getFriends() async =>
      FriendsEntity.fromJson(json.decode(await _makeGetRequest('get_friends')));

  /// This method is used to get friend of the current user it takes input friend_id
  getFriend(int id) async => FriendEntity.fromJson(
      json.decode(await _makeGetRequest('get_friend/$id')));

  /// This method is used to create a Friend
  createFriend(Map<String, String> options) async => FriendEntity.fromJson(
      json.decode(await _makePostRequest('create_friend', options: options)));

  /// This method is used to create multiple friends
  createFriends(Map<String, String> options) async => FriendsEntity.fromJson(
      json.decode(await _makePostRequest('create_friends', options: options)));

  /// This method is used to delete friend
  deleteFriend(int id) async {
    var t = PostResponse.fromJson(
        json.decode(await _makePostRequest('delete_friend/$id')));
    return t.success ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Expenses Section">

  /// This method is used to get Expense
  getExpense(int id) async => ExpensesBean.fromJson(
      json.decode(await _makeGetRequest('get_expense/$id')));

  /// This method is used to get all Expenses
  getExpenses({Map<String, String> options}) async => ExpensesEntity.fromJson(
      json.decode(await _makeGetRequest('get_expenses', options: options)));

  /// This method is used to create an Expense
  createExpense(Map<String, String> options) async {
    PostExpense.fromJson(json
        .decode(await _makePostRequest('create_expense', options: options)));
  }

  /// This method is used to update an expense
  updateExpense(int id, Map<String, String> options) async =>
      PostExpense.fromJson(json.decode(
          await _makePostRequest('update_expense/$id', options: options)));

  /// This method is used to delete an expense
  deleteExpense(int id) async {
    var t = PostResponse.fromJson(
        json.decode(await _makePostRequest('delete_expense/$id')));
    return t.success ? true : t.errors;
  }

  /// This method is used to un-delete an expense
  unDeleteExpense(int id) async {
    var t = PostResponse.fromJson(
        json.decode(await _makePostRequest('undelete_expense/$id')));
    return t.success ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Comments Section">

  /// This method is used to getComments from ant expense
  getComments(int id) async => CommentsEntity.fromJson(json.decode(
      await _makeGetRequest('get_comments', options: {'expense_id': '$id'})));

  /// This method is used to create Comment on  any Expense
  createComment(Map<String, String> options) async =>
      _makePostRequest('create_comment', options: options);

  /// This method is used to delete a Comment
  deleteComment(int id) async => _makePostRequest('delete_comment/$id');

//</editor-fold>

//<editor-fold desc="Notification Section">

  /// This method is used to get All the Notification
  getNotifications({Map<String, String> options}) async =>
      NotificationsEntity.fromJson(json.decode(
          await _makeGetRequest('get_notifications', options: options)));

//</editor-fold>

//<editor-fold desc="Currencies Section">

  /// This method is used to get all supported Currencies
  getCurrencies() async => _makeGetRequest('get_currencies');

  /// This method is used to get all the categories
  getCategories() async => CategoriesEntity.fromJson(
      json.decode(await _makeGetRequest('get_categories')));

  /// This method is used to parse a sentence
  parseSentence(Map<String, String> options) async =>
      _makePostRequest('parse_sentence', options: options);

//</editor-fold>

}
