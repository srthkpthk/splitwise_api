import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../exceptions.dart';
import 'oauth2_token.dart';

/// Implements the OAuth 2.0 authorization-code flow for Splitwise.
///
/// Register your application at <https://secure.splitwise.com/apps> to get a
/// consumer key (client ID) and secret, and configure its callback URL.
///
/// ```dart
/// final oauth = SplitwiseOAuth2(
///   clientId: 'CONSUMER_KEY',
///   clientSecret: 'CONSUMER_SECRET',
///   redirectUri: Uri.parse('https://example.com/callback'),
/// );
///
/// // 1. Send the user to the authorization page; keep `state` for step 2.
/// final state = SplitwiseOAuth2.generateState();
/// final url = oauth.authorizationUrl(state: state);
///
/// // 2. Splitwise redirects to redirectUri?code=...&state=...
/// if (callback.queryParameters['state'] != state) {
///   throw StateError('OAuth state mismatch');
/// }
/// final token = await oauth.exchangeCode(callback.queryParameters['code']!);
///
/// // 3. Persist token.toJson() and use the access token.
/// final client = SplitwiseClient.accessToken(token.accessToken);
/// ```
///
/// The OAuth endpoints live on `www.splitwise.com` (the host used by the
/// official web app and other production SDKs); override [oauthBaseUrl] if
/// Splitwise moves them.
class SplitwiseOAuth2 {
  /// Creates an OAuth 2.0 helper.
  ///
  /// [httpClient] lets you supply your own [http.Client]; it will not be
  /// closed by [close].
  SplitwiseOAuth2({
    required this.clientId,
    required String clientSecret,
    required this.redirectUri,
    http.Client? httpClient,
    Uri? oauthBaseUrl,
  }) : _clientSecret = clientSecret,
       oauthBaseUrl = _normalize(oauthBaseUrl ?? defaultOAuthBaseUrl),
       _client = httpClient ?? http.Client(),
       _ownsClient = httpClient == null;

  /// The host the OAuth endpoints are resolved against.
  static final Uri defaultOAuthBaseUrl = Uri.parse(
    'https://www.splitwise.com/',
  );

  static Uri _normalize(Uri uri) =>
      uri.path.endsWith('/') ? uri : uri.replace(path: '${uri.path}/');

  /// Your application's consumer key.
  final String clientId;

  /// The callback URL registered for your application.
  final Uri redirectUri;

  /// Base URL of the OAuth endpoints; always ends with `/`.
  final Uri oauthBaseUrl;

  final String _clientSecret;
  final http.Client _client;
  final bool _ownsClient;

  /// The URL to open in a browser so the user can authorize your app.
  ///
  /// Pass a random [state] and verify it on the redirect to protect against
  /// CSRF.
  Uri authorizationUrl({String? state}) => oauthBaseUrl
      .resolve('oauth/authorize')
      .replace(
        queryParameters: {
          'response_type': 'code',
          'client_id': clientId,
          'redirect_uri': redirectUri.toString(),
          'state': ?state,
        },
      );

  /// Exchanges the authorization [code] from the redirect for an access
  /// token.
  ///
  /// Throws [SplitwiseOAuth2Exception] if Splitwise rejects the code or
  /// returns an unexpected body.
  Future<OAuth2Token> exchangeCode(String code) async {
    final uri = oauthBaseUrl.resolve('oauth/token');
    final request = http.Request('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..bodyFields = {
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'client_secret': _clientSecret,
        'code': code,
        'redirect_uri': redirectUri.toString(),
      };

    final response = await http.Response.fromStream(
      await _client.send(request),
    );

    Object? json;
    try {
      json = jsonDecode(response.body);
    } on FormatException {
      json = null;
    }

    if (response.statusCode == 200 &&
        json is Map<String, dynamic> &&
        json['access_token'] is String) {
      return OAuth2Token.fromJson(json);
    }

    final error = json is Map ? json['error'] : null;
    final description = json is Map ? json['error_description'] : null;
    throw SplitwiseOAuth2Exception(
      statusCode: response.statusCode,
      method: 'POST',
      uri: uri,
      body: response.body,
      error: error?.toString(),
      errorDescription: description?.toString(),
    );
  }

  /// Generates a random, URL-safe `state` value for [authorizationUrl].
  ///
  /// Store it alongside the pending authorization and compare it with the
  /// `state` query parameter on the redirect before calling [exchangeCode];
  /// a mismatch means the callback was not initiated by your app.
  static String generateState({int bytes = 32}) {
    final random = Random.secure();
    final data = Uint8List.fromList(
      List<int>.generate(bytes, (_) => random.nextInt(256)),
    );
    return base64UrlEncode(data).replaceAll('=', '');
  }

  /// Releases the underlying HTTP client if this instance created it.
  void close() {
    if (_ownsClient) {
      _client.close();
    }
  }
}
