import 'dart:convert';

/// A helper class for managing OAuth 1.0 access tokens for Splitwise API.
///
/// This class encapsulates the OAuth token and token secret required for
/// authenticated API requests. It provides convenient methods for:
/// * Token persistence (serialization/deserialization)
/// * Token restoration across app sessions
/// * Secure token storage integration
///
/// ## Usage
///
/// **Creating from OAuth response:**
/// ```dart
/// // After successful OAuth authentication
/// final tokens = TokensHelper(accessToken, tokenSecret);
/// ```
///
/// **Saving tokens for persistent authentication:**
/// ```dart
/// // Convert to JSON for storage
/// final jsonString = jsonEncode(tokens.toJSON());
/// await prefs.setString('splitwise_tokens', jsonString);
/// ```
///
/// **Loading saved tokens:**
/// ```dart
/// // Restore from storage
/// final savedJson = prefs.getString('splitwise_tokens');
/// final tokens = TokensHelper.fromJSON(savedJson!);
///
/// // Use with SplitWiseService
/// await service.validateClient(tokens: tokens);
/// ```
///
/// **Creating from Map (OAuth parameters):**
/// ```dart
/// final params = {
///   'oauth_token': 'token_value',
///   'oauth_token_secret': 'secret_value',
/// };
/// final tokens = TokensHelper.fromMap(params);
/// ```
///
/// ## Security Note
///
/// Always store tokens securely using:
/// * `flutter_secure_storage` for production apps
/// * `shared_preferences` for development (less secure)
/// * Never commit tokens to version control
///
/// See also:
/// * [SplitWiseService.validateClient] for using tokens
class TokensHelper {
  final String? _token;
  final String? _tokenSecret;

  /// Creates a new TokensHelper instance with the provided OAuth credentials.
  ///
  /// Parameters:
  /// * [_token] - The OAuth access token
  /// * [_tokenSecret] - The OAuth token secret
  ///
  /// Both parameters are nullable to support null-safety, but should
  /// typically contain valid token values for authenticated requests.
  ///
  /// Example:
  /// ```dart
  /// final tokens = TokensHelper('my_token', 'my_secret');
  /// ```
  TokensHelper(this._token, this._tokenSecret);

  /// Creates a TokensHelper instance from a Map of OAuth parameters.
  ///
  /// This factory constructor is useful when working with OAuth response
  /// parameters that come as key-value pairs.
  ///
  /// Required keys in the map:
  /// * `oauth_token` - The OAuth access token
  /// * `oauth_token_secret` - The OAuth token secret
  ///
  /// Example:
  /// ```dart
  /// final params = {
  ///   'oauth_token': 'abc123...',
  ///   'oauth_token_secret': 'xyz789...',
  /// };
  /// final tokens = TokensHelper.fromMap(params);
  /// ```
  ///
  /// Parameters:
  /// * [parameters] - Map containing OAuth token parameters
  ///
  /// Returns:
  /// * [TokensHelper] instance with the extracted tokens
  ///
  /// Throws:
  /// * [ArgumentError] if required keys are missing from the map
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

  /// Creates a TokensHelper instance from a JSON string.
  ///
  /// This factory constructor deserializes a JSON string back into a
  /// TokensHelper instance. Use this to restore saved tokens from storage.
  ///
  /// The JSON string must contain:
  /// * `oauth_token` field
  /// * `oauth_token_secret` field
  ///
  /// Example:
  /// ```dart
  /// // Load from shared preferences or secure storage
  /// final savedJson = await prefs.getString('splitwise_tokens');
  /// if (savedJson != null) {
  ///   final tokens = TokensHelper.fromJSON(savedJson);
  ///   await service.validateClient(tokens: tokens);
  /// }
  /// ```
  ///
  /// Parameters:
  /// * [jstr] - JSON string containing serialized OAuth tokens
  ///
  /// Returns:
  /// * [TokensHelper] instance with the deserialized tokens
  ///
  /// Throws:
  /// * [FormatException] if JSON string is malformed
  /// * [ArgumentError] if required fields are missing
  ///
  /// See also:
  /// * [toJSON] for serializing tokens
  /// * [fromMap] which this method uses internally
  factory TokensHelper.fromJSON(String jstr) {
    return TokensHelper.fromMap(json.decode(jstr));
  }

  /// The OAuth access token.
  ///
  /// This token is used along with [tokenSecret] to authenticate
  /// API requests to Splitwise.
  ///
  /// Returns:
  /// * [String?] - The access token, or null if not set
  String? get token => _token;

  /// The OAuth token secret.
  ///
  /// This secret is used along with [token] to sign authenticated
  /// API requests to Splitwise using HMAC-SHA1.
  ///
  /// Returns:
  /// * [String?] - The token secret, or null if not set
  String? get tokenSecret => _tokenSecret;

  /// Returns a string representation of the tokens in OAuth format.
  ///
  /// The format is: `oauth_token=<token>&oauth_token_secret=<secret>`
  ///
  /// This is primarily used for debugging and logging purposes.
  /// For secure storage, use [toJSON] instead.
  ///
  /// Example:
  /// ```dart
  /// print(tokens.toString());
  /// // Output: oauth_token=abc123&oauth_token_secret=xyz789
  /// ```
  ///
  /// Returns:
  /// * [String] - URL-encoded OAuth parameter string
  ///
  /// Warning: This exposes sensitive token information. Avoid logging
  /// in production environments.
  @override
  String toString() {
    return 'oauth_token=$token&oauth_token_secret=$tokenSecret';
  }

  /// Converts the tokens to a JSON-serializable Map.
  ///
  /// This method is used to prepare tokens for persistent storage.
  /// The returned Map can be serialized to JSON using `jsonEncode()`.
  ///
  /// Example with shared_preferences:
  /// ```dart
  /// // Save tokens
  /// final jsonMap = tokens.toJSON();
  /// final jsonString = jsonEncode(jsonMap);
  /// await prefs.setString('splitwise_tokens', jsonString);
  /// ```
  ///
  /// Example with flutter_secure_storage:
  /// ```dart
  /// // Secure storage
  /// final storage = FlutterSecureStorage();
  /// await storage.write(
  ///   key: 'splitwise_tokens',
  ///   value: jsonEncode(tokens.toJSON()),
  /// );
  /// ```
  ///
  /// Returns:
  /// * [Map<String, dynamic>] containing:
  ///   * `oauth_token` - The access token
  ///   * `oauth_token_secret` - The token secret
  ///
  /// See also:
  /// * [fromJSON] for deserializing tokens
  /// * [toString] for OAuth parameter format
  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'oauth_token': token,
      'oauth_token_secret': tokenSecret
    };
  }
}
