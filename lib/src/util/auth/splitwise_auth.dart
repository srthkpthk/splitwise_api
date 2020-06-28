import 'dart:convert';

import 'package:oauth1/oauth1.dart' as oauth;
import 'package:splitwise_api/src/util/data/model/categoriesSection/CategoriesEntity.dart';
import 'package:splitwise_api/src/util/data/model/commentsSection/comments/comments.dart';
import 'package:splitwise_api/src/util/data/model/expensesSection/expenses/ExpensesEntity.dart';
import 'package:splitwise_api/src/util/data/model/expensesSection/expenses/expenses.dart';
import 'package:splitwise_api/src/util/data/model/expensesSection/postExpense/PostExpenseEntity.dart';
import 'package:splitwise_api/src/util/data/model/friendsSection/friend/FriendEntity.dart';
import 'package:splitwise_api/src/util/data/model/friendsSection/friends/FriendsEntity.dart';
import 'package:splitwise_api/src/util/data/model/friendsSection/friends/friends.dart';
import 'package:splitwise_api/src/util/data/model/groupSection/group/GroupEntity.dart';
import 'package:splitwise_api/src/util/data/model/groupSection/groups/GroupsEntity.dart';
import 'package:splitwise_api/src/util/data/model/notificationSection/getNotifications/NotificationEntity.dart';
import 'package:splitwise_api/src/util/data/model/postResponse/PostResponse.dart';
import 'package:splitwise_api/src/util/data/model/userSection/currentUser/CurrentUserEntity.dart';
import 'package:splitwise_api/src/util/data/model/userSection/user/User.dart';

class SplitWiseService {
//<editor-fold desc="Method Utils">

  _makeGetRequest(String path, {Map<String, String> options}) async {
    if (_client == null) {
      throw Exception('User validateClient First');
    } else {
      var t = await _client.get(Uri.https('secure.splitwise.com', '/api/v3.0/$path', options));
      return t.statusCode == 200 ? t.body : t.statusCode;
    }
  }

  _makePostRequest(String path, {Map<String, String> options}) async {
    if (_client == null) {
      throw Exception('User validateClient First');
    } else {
      var t = await _client.post(Uri.https('secure.splitwise.com', '/api/v3.0/$path', options));
      return t.statusCode == 200 ? t.body : t.statusCode;
    }
  }

//</editor-fold> {

//<editor-fold desc="Authorization Section">
  oauth.Platform _platform = oauth.Platform(
      'https://secure.splitwise.com/oauth/request_token',
      'https://secure.splitwise.com/oauth/authorize',
      'https://secure.splitwise.com/oauth/access_token',
      oauth.SignatureMethods.hmacSha1);

  oauth.ClientCredentials _clientCredentials;
  oauth.Authorization _auth;
  oauth.Client _client;
  oauth.AuthorizationResponse url;

  SplitWiseService.initialize(String _consumerKey, String _consumerSecret) {
    _clientCredentials = oauth.ClientCredentials(_consumerKey, _consumerSecret);
    _auth = oauth.Authorization(_clientCredentials, _platform);
  }

  validateClient({String verifier, String token, String tokenSecret}) async {
    if (verifier == null && tokenSecret == null && token == null) {
      url = await _auth.requestTemporaryCredentials('oob');
      return _auth.getResourceOwnerAuthorizationURI(url.credentials.token);
    } else if ((verifier != null && verifier.isNotEmpty) && (token == null) && (tokenSecret == null)) {
      var cred = await _auth.requestTokenCredentials(url.credentials, verifier);
      print(cred.credentials);
      print('Save these both to SharedPrefs or any where these are required for keep signed in ');
      _client = oauth.Client(oauth.SignatureMethods.hmacSha1, _clientCredentials, cred.credentials);
    } else {
      _client = oauth.Client(oauth.SignatureMethods.hmacSha1, _clientCredentials, oauth.Credentials(token, tokenSecret));
      return _client;
    }
  }

//</editor-fold>

//<editor-fold desc="User Section">
  getCurrentUser() async => CurrentUserEntity.fromJsonMap(json.decode(await _makeGetRequest('get_current_user')));

  getUser(int id) async => User.fromJsonMap(json.decode(await _makeGetRequest('get_user/$id')));

  updateUser(int id, Map<String, String> options) async => CurrentUserEntity.fromJsonMap(
      json.decode(await _makePostRequest('https://www.splitwise.comupdate_user/$id', options: options)));

//</editor-fold>

//<editor-fold desc="Group Section">
  getGroups() async => GroupsEntity.fromJsonMap(json.decode(await _makeGetRequest('get_groups')));

  getGroup(int id) async => GroupEntity.fromJsonMap(json.decode(await _makeGetRequest('get_group/$id')));

  createGroup(Map<String, String> options) async =>
      GroupEntity.fromJsonMap(json.decode(await _makePostRequest('create_group', options: options)));

  deleteGroup(int id) async {
    var t = PostResponse.fromJsonMap(json.decode(await _makePostRequest('delete_group/$id')));
    return t.success ? true : t.errors;
  }

  unDeleteGroup(int id) async {
    var t = PostResponse.fromJsonMap(json.decode(await _makePostRequest('undelete_group/$id')));
    return t.success ? true : t.errors;
  }

  addUserToGroup(Map<String, String> options) async {
    var t = PostResponse.fromJsonMap(json.decode(await _makePostRequest('add_user_to_group')));
    return t.success ? true : t.errors;
  }

  removeUserFromGroup(Map<String, int> options) async {
    var t = PostResponse.fromJsonMap(json.decode(await _makePostRequest('remove_user_from_group')));
    return t.success ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Friends Section">
  getFriends() async => FriendsEntity.fromJsonMap(json.decode(await _makeGetRequest('get_friends')));

  getFriend(int id) async => FriendEntity.fromJsonMap(json.decode(await _makeGetRequest('get_friend/$id')));

  createFriend(Map<String, String> options) async =>
      FriendEntity.fromJsonMap(json.decode(await _makePostRequest('create_friend', options: options)));

  createFriends(Map<String, String> options) async =>
      Friends.fromJsonMap(json.decode(await _makePostRequest('create_friends', options: options)));

  deleteFriend(int id) async {
    var t = PostResponse.fromJsonMap(json.decode(await _makePostRequest('delete_friend/$id')));
    return t.success ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Expenses Section">
  getExpense(int id) async => Expenses.fromJsonMap(json.decode(await _makeGetRequest('get_expense/$id')));

  getExpenses({Map<String, String> options}) async =>
      ExpensesEntity.fromJsonMap(json.decode(await _makeGetRequest('get_expenses', options: options)));

  createExpense(Map<String, String> options) async {
    PostExpenseEntity.fromJsonMap(json.decode(await _makePostRequest('create_expense', options: options)));
  }

  updateExpense(int id, Map<String, String> options) async =>
      PostExpenseEntity.fromJsonMap(json.decode(await _makePostRequest('update_expense/$id', options: options)));

  deleteExpense(int id) async {
    var t = PostResponse.fromJsonMap(json.decode(await _makePostRequest('delete_expense/$id')));
    return t.success ? true : t.errors;
  }

  unDeleteExpense(int id) async {
    var t = PostResponse.fromJsonMap(json.decode(await _makePostRequest('undelete_expense/$id')));
    return t.success ? true : t.errors;
  }

//</editor-fold>

//<editor-fold desc="Comments Section">

  getComments(int id) async =>
      Comments.fromJsonMap(json.decode(await _makeGetRequest('get_comments', options: {'expense_id': '$id'})));

  createComment(Map<String, String> options) async => _makePostRequest('create_comment', options: options);

  deleteComment(int id) async => _makePostRequest('delete_comment/$id');

//</editor-fold>

//<editor-fold desc="Notification Section">
  getNotifications({Map<String, String> options}) async =>
      NotificationEntity.fromJsonMap(json.decode(await _makeGetRequest('get_notifications', options: options)));

//</editor-fold>

//<editor-fold desc="Currencies Section">

  getCurrencies() async => _makeGetRequest('get_currencies');

  getCategories() async => CategoriesEntity.fromJsonMap(json.decode(await _makeGetRequest('get_categories')));

  parseSentence(Map<String, String> options) async => _makePostRequest('parse_sentence', options: options);

//</editor-fold>
}
