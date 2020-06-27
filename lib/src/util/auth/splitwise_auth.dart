import 'dart:convert';

import 'package:oauth1/oauth1.dart' as oauth;

class SplitWiseAuth {
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
//<editor-fold desc="Method Utils">

//</editor-fold>
}
