/// An OAuth 2.0 access token issued by Splitwise.
///
/// Persist it with [toJson] and restore it with [OAuth2Token.fromJson], then
/// pass [accessToken] to `SplitwiseClient.accessToken`.
///
/// Splitwise does not currently issue refresh tokens or expiry times;
/// [refreshToken] and [expiresAt] are kept for forward compatibility and
/// are `null` in practice.
final class OAuth2Token {
  /// Creates a token.
  const OAuth2Token({
    required this.accessToken,
    this.tokenType = 'bearer',
    this.refreshToken,
    this.expiresAt,
  });

  /// Deserializes a token from a token-endpoint response or from a map
  /// produced by [toJson].
  ///
  /// Accepts `access_token`, `token_type`, `refresh_token` and either
  /// `expires_at` (ISO 8601) or `expires_in` (seconds from now).
  ///
  /// Throws [FormatException] if `access_token` is missing.
  factory OAuth2Token.fromJson(Map<String, dynamic> json, {DateTime? now}) {
    final accessToken = json['access_token'];
    if (accessToken is! String || accessToken.isEmpty) {
      throw const FormatException('OAuth2 token JSON has no "access_token"');
    }
    DateTime? expiresAt;
    final rawExpiresAt = json['expires_at'];
    final rawExpiresIn = json['expires_in'];
    if (rawExpiresAt is String) {
      expiresAt = DateTime.tryParse(rawExpiresAt);
    } else if (rawExpiresIn is num) {
      expiresAt = (now ?? DateTime.now()).toUtc().add(
        Duration(seconds: rawExpiresIn.toInt()),
      );
    }
    return OAuth2Token(
      accessToken: accessToken,
      tokenType: json['token_type'] as String? ?? 'bearer',
      refreshToken: json['refresh_token'] as String?,
      expiresAt: expiresAt,
    );
  }

  /// The bearer token to send in the `Authorization` header.
  final String accessToken;

  /// The token type reported by the server (`bearer`).
  final String tokenType;

  /// A refresh token, if the server issued one.
  final String? refreshToken;

  /// When the token expires, if the server said so.
  final DateTime? expiresAt;

  /// Serializes the token for persistence.
  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'token_type': tokenType,
    if (refreshToken != null) 'refresh_token': refreshToken,
    if (expiresAt != null) 'expires_at': expiresAt!.toUtc().toIso8601String(),
  };

  @override
  String toString() => 'OAuth2Token(tokenType: $tokenType, accessToken: ***)';
}
