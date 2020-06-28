import 'package:oauth1/oauth1.dart' as oauth;

class SplitWiseAuth {
//<editor-fold desc="Method Utils">

  _makeGetRequest(String path, {Map<String, String> options}) async {
    if (_client == null) {
      throw Exception('User validateClient First');
    } else {
      var t = await _client.get(Uri.https('secure.splitwise.com', path, options));
      print(t.body);
      return t;
    }
  }

  _makePostRequest(String url, {Map<String, dynamic> options}) async {
    if (_client == null) {
      throw Exception('User validateClient First');
    } else {
      var t = await _client.post(url, body: options);
      print(t.body);
      return t;
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

  SplitWiseAuth.initialize(String _consumerKey, String _consumerSecret) {
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
      print('Save these both to SharedPerefs or any where these are required for keep signed in ');
      _client = oauth.Client(oauth.SignatureMethods.hmacSha1, _clientCredentials, cred.credentials);
    } else {
      _client = oauth.Client(oauth.SignatureMethods.hmacSha1, _clientCredentials,
          oauth.Credentials('aetEdlQFkBSvTfFtTiHpLcwAn19mAssj1PGieTgA', 'ecqLLIKnNDIqa3SqwX6gKpIirSeqgx4mUe78S4V0'));
      return _client;
    }
  }

//</editor-fold>

//<editor-fold desc="User Section">
  getCurrentUser() => _makeGetRequest('/api/v3.0/get_current_user');

  getUser(int id) => _makeGetRequest('/api/v3.0/get_user/$id');

  updateUser(int id, {Map<String, dynamic> options}) =>
      _makePostRequest('https://www.splitwise.com/api/v3.0/update_user/$id', options: options);

//</editor-fold>

//<editor-fold desc="Group Section">
  getGroups() => _makeGetRequest('/api/v3.0/get_groups');

  getGroup(int id) => _makeGetRequest('/api/v3.0/get_group/$id');

  createGroup(Map<String, dynamic> options) => _makePostRequest('https://secure.splitwise.com/api/v3.0/create_group');

  deleteGroup(int id) => _makePostRequest('https://secure.splitwise.com/api/v3.0/delete_group/$id');

  undeleteGroup(int id) => _makePostRequest('https://secure.splitwise.com/api/v3.0/undelete_group/$id');

  addUserToGroup(Map<String, dynamic> options) => _makePostRequest('https://secure.splitwise.com/api/v3.0/add_user_to_group');

  removeUserFromGroup(Map<String, int> options) =>
      _makePostRequest('https://secure.splitwise.com/api/v3.0/remove_user_from_group', options: options);

//</editor-fold>

//<editor-fold desc="Friends Section">
  getFriends() => _makeGetRequest('/api/v3.0/get_friends');

  getFriend(int id) => _makeGetRequest('/api/v3.0/get_friend/$id');

  createFriend(Map<String, dynamic> options) =>
      _makePostRequest('https://secure.splitwise.com/api/v3.0/create_friend', options: options);

  createFriends(Map<String, dynamic> options) =>
      _makePostRequest('https://secure.splitwise.com/api/v3.0/create_friends', options: options);

  deleteFriend(int id) => _makePostRequest('https://secure.splitwise.com/api/v3.0/delete_friend/$id');

//</editor-fold>

//<editor-fold desc="Expenses Section">
  getExpense(int id) => _makeGetRequest('/api/v3.0/get_expense/:id');

  getExpenses({Map<String, String> options}) => _makeGetRequest('/api/v3.0/get_expenses', options: options);

  createExpense(Map<String, dynamic> options) =>
      _makePostRequest('https://secure.splitwise.com/api/v3.0/create_expense', options: options);

  updateExpense(int id, Map<String, dynamic> options) =>
      _makePostRequest('https://secure.splitwise.com/api/v3.0/update_expense/$id', options: options);

  deleteExpense(int id) => _makePostRequest('https://secure.splitwise.com/api/v3.0/delete_expense/$id');

  unDeleteExpense(int id) => _makePostRequest('https://secure.splitwise.com/api/v3.0/undelete_expense/$id');

//</editor-fold>

//<editor-fold desc="Comments Section">
  createComment(Map<String, dynamic> options) =>
      _makePostRequest('https://secure.splitwise.com/api/v3.0/create_comment', options: options);

  deleteComment(int id) => _makePostRequest('https://secure.splitwise.com/api/v3.0/delete_comment/$id');

//</editor-fold>

//<editor-fold desc="Notification Section">
  getNotifications({Map<String, String> options}) => _makeGetRequest('/api/v3.0/get_notifications', options: options);

//</editor-fold>

//<editor-fold desc="Currencies Section">

  getCurrencies() => _makeGetRequest('/api/v3.0/get_currencies');

  getCategories() => _makeGetRequest('/api/v3.0/get_categories');

  parseSentence(Map<String, dynamic> options) =>
      _makePostRequest('https://secure.splitwise.com/api/v3.0/parse_sentence', options: options);

//</editor-fold>
}
