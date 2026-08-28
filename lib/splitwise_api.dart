/// A typed Dart client for the Splitwise API v3.0.
///
/// Start with [SplitwiseClient.apiKey] for a personal API key, or
/// [SplitwiseOAuth2] to obtain an access token for [SplitwiseClient.accessToken].
library;

export 'src/auth/oauth2_token.dart';
export 'src/auth/splitwise_oauth2.dart';
export 'src/exceptions.dart';
export 'src/models/models.dart';
export 'src/splitwise_client.dart';
export 'src/transport.dart' show BodyEncoding;
