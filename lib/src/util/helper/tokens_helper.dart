import 'dart:convert';

/// A class describing OAuth credentials except for client credential
class TokensHelper {
  final String? _token;
  final String? _tokenSecret;

  TokensHelper(this._token, this._tokenSecret);

  factory TokensHelper.fromMap(Map<String, String> parameters) {
    if (!parameters.containsKey('oauth_token')) {
      throw ArgumentError("params doesn't have a key 'oauth_token'");
    }
    if (!parameters.containsKey('oauth_token_secret')) {
      throw ArgumentError("params doesn't have a key 'oauth_token_secret'");
    }
    return TokensHelper(
        parameters['oauth_token']!, parameters['oauth_token_secret']!);
  }

  factory TokensHelper.fromJSON(String jstr) {
    return TokensHelper.fromMap(json.decode(jstr));
  }

  String? get token => _token;

  String? get tokenSecret => _tokenSecret;

  @override
  String toString() {
    return 'oauth_token=$token&oauth_token_secret=$tokenSecret';
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'oauth_token': token,
      'oauth_token_secret': tokenSecret
    };
  }
}
