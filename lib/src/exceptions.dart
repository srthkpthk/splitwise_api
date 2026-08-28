/// Base class for every exception thrown by this package.
class SplitwiseException implements Exception {
  /// Creates an exception with a human-readable [message].
  const SplitwiseException(this.message);

  /// Description of what went wrong.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Validation or business errors reported by the Splitwise API, grouped by
/// the field they refer to.
///
/// Splitwise uses several shapes for errors; this class normalises all of
/// them:
///
/// * `{"error": "message"}` (401 responses)
/// * `{"errors": {"base": ["message"]}}` (403/404 and most failures)
/// * `{"errors": {"field": ["message"]}}` (validation errors)
/// * `{"errors": ["message"]}` (`undelete_group`)
/// * `{"errors": {}}` / `{"errors": []}` (no errors)
///
/// Untargeted messages are stored under the key `base`.
final class SplitwiseErrors {
  /// Creates an error set from messages grouped by field.
  const SplitwiseErrors(this.byField);

  /// An empty error set.
  const SplitwiseErrors.empty() : byField = const {};

  /// Parses the `errors` / `error` member of a decoded response [body].
  ///
  /// Returns an empty set if the body carries no errors or is not a JSON
  /// object.
  factory SplitwiseErrors.fromResponseJson(Object? body) {
    if (body is! Map) {
      return const SplitwiseErrors.empty();
    }
    if (body.containsKey('errors')) {
      return SplitwiseErrors._fromErrorsValue(body['errors']);
    }
    final error = body['error'];
    if (error is String && error.isNotEmpty) {
      return SplitwiseErrors({
        'base': [error],
      });
    }
    return const SplitwiseErrors.empty();
  }

  factory SplitwiseErrors._fromErrorsValue(Object? value) {
    if (value is Map) {
      return SplitwiseErrors({
        for (final entry in value.entries)
          entry.key.toString(): _messagesOf(entry.value),
      });
    }
    final messages = _messagesOf(value);
    if (messages.isEmpty) {
      return const SplitwiseErrors.empty();
    }
    return SplitwiseErrors({'base': messages});
  }

  static List<String> _messagesOf(Object? value) {
    if (value == null) {
      return const [];
    }
    if (value is List) {
      return [for (final v in value) v.toString()];
    }
    return [value.toString()];
  }

  /// Messages keyed by the field they refer to; `base` for untargeted ones.
  final Map<String, List<String>> byField;

  /// Whether no error message is present.
  bool get isEmpty => byField.values.every((messages) => messages.isEmpty);

  /// Whether at least one error message is present.
  bool get isNotEmpty => !isEmpty;

  /// All messages flattened into a single list.
  ///
  /// Messages attached to a field other than `base` are prefixed with the
  /// field name, e.g. `cost: can't be blank`.
  List<String> get messages => [
    for (final entry in byField.entries)
      for (final message in entry.value)
        if (entry.key == 'base') message else '${entry.key}: $message',
  ];

  @override
  String toString() => messages.join('; ');
}

/// Thrown when the Splitwise API responds with a non-2xx status code.
///
/// More specific subclasses exist for the documented status codes; catch this
/// type to handle any HTTP failure.
class SplitwiseHttpException extends SplitwiseException {
  /// Creates an exception for an HTTP failure.
  SplitwiseHttpException({
    required this.statusCode,
    required this.method,
    required this.uri,
    required this.body,
    SplitwiseErrors? errors,
    String? message,
  }) : errors = errors ?? const SplitwiseErrors.empty(),
       super(message ?? _describe(statusCode, method, uri, errors));

  /// Builds the most specific exception type for [statusCode].
  ///
  /// [json] is the decoded response body, or `null` when it is not JSON.
  factory SplitwiseHttpException.forStatus({
    required int statusCode,
    required String method,
    required Uri uri,
    required String body,
    Object? json,
    String? retryAfterHeader,
  }) {
    final errors = SplitwiseErrors.fromResponseJson(json);
    switch (statusCode) {
      case 400:
        return SplitwiseBadRequestException(
          method: method,
          uri: uri,
          body: body,
          errors: errors,
        );
      case 401:
        return SplitwiseUnauthorizedException(
          method: method,
          uri: uri,
          body: body,
          errors: errors,
        );
      case 403:
        return SplitwiseForbiddenException(
          method: method,
          uri: uri,
          body: body,
          errors: errors,
        );
      case 404:
        return SplitwiseNotFoundException(
          method: method,
          uri: uri,
          body: body,
          errors: errors,
        );
      case 429:
        return SplitwiseRateLimitException(
          method: method,
          uri: uri,
          body: body,
          errors: errors,
          retryAfter: _parseRetryAfter(retryAfterHeader),
        );
      default:
        return SplitwiseHttpException(
          statusCode: statusCode,
          method: method,
          uri: uri,
          body: body,
          errors: errors,
        );
    }
  }

  static String _describe(
    int statusCode,
    String method,
    Uri uri,
    SplitwiseErrors? errors,
  ) {
    final base = 'HTTP $statusCode for $method $uri';
    if (errors == null || errors.isEmpty) {
      return base;
    }
    return '$base: $errors';
  }

  static Duration? _parseRetryAfter(String? header) {
    if (header == null) {
      return null;
    }
    final seconds = int.tryParse(header.trim());
    if (seconds == null || seconds < 0) {
      return null;
    }
    return Duration(seconds: seconds);
  }

  /// The HTTP status code of the response.
  final int statusCode;

  /// The HTTP method of the failed request.
  final String method;

  /// The URI of the failed request.
  final Uri uri;

  /// The raw response body (may be HTML or empty).
  final String body;

  /// Errors parsed from the response body, if it was JSON.
  final SplitwiseErrors errors;
}

/// Thrown for `400 Bad Request` responses (for example a `create_group` call
/// with validation errors).
class SplitwiseBadRequestException extends SplitwiseHttpException {
  /// Creates a 400 exception.
  SplitwiseBadRequestException({
    required super.method,
    required super.uri,
    required super.body,
    super.errors,
  }) : super(statusCode: 400);
}

/// Thrown for `401 Unauthorized` responses: the API key or access token is
/// missing, invalid, or revoked.
class SplitwiseUnauthorizedException extends SplitwiseHttpException {
  /// Creates a 401 exception.
  SplitwiseUnauthorizedException({
    required super.method,
    required super.uri,
    required super.body,
    super.errors,
  }) : super(statusCode: 401);
}

/// Thrown for `403 Forbidden` responses: the authenticated user may not
/// access the requested resource.
class SplitwiseForbiddenException extends SplitwiseHttpException {
  /// Creates a 403 exception.
  SplitwiseForbiddenException({
    required super.method,
    required super.uri,
    required super.body,
    super.errors,
  }) : super(statusCode: 403);
}

/// Thrown for `404 Not Found` responses.
class SplitwiseNotFoundException extends SplitwiseHttpException {
  /// Creates a 404 exception.
  SplitwiseNotFoundException({
    required super.method,
    required super.uri,
    required super.body,
    super.errors,
  }) : super(statusCode: 404);
}

/// Thrown for `429 Too Many Requests` responses.
///
/// Splitwise documents that clients "should slow down the rate at which
/// you're making requests and retry after a short delay". This package does
/// not retry automatically.
class SplitwiseRateLimitException extends SplitwiseHttpException {
  /// Creates a 429 exception.
  SplitwiseRateLimitException({
    required super.method,
    required super.uri,
    required super.body,
    super.errors,
    this.retryAfter,
  }) : super(statusCode: 429);

  /// The `Retry-After` delay, if the response carried one in seconds.
  final Duration? retryAfter;
}

/// Thrown when the OAuth 2.0 token endpoint rejects a request or returns an
/// unexpected body.
class SplitwiseOAuth2Exception extends SplitwiseHttpException {
  /// Creates an OAuth 2.0 exception.
  SplitwiseOAuth2Exception({
    required super.statusCode,
    required super.method,
    required super.uri,
    required super.body,
    this.error,
    this.errorDescription,
    String? message,
  }) : super(
         message:
             message ??
             'OAuth 2.0 token request failed with HTTP $statusCode'
                 '${error == null ? '' : ' ($error'
                           '${errorDescription == null ? '' : ': $errorDescription'})'}',
       );

  /// The RFC 6749 `error` code, if the response was JSON.
  final String? error;

  /// The RFC 6749 `error_description`, if the response was JSON.
  final String? errorDescription;
}

/// Thrown when the API returns a 2xx status but reports that the operation
/// failed (`"success": false` or a non-empty `errors` member).
///
/// Splitwise documents that for several write operations "a 200 OK does not
/// indicate a successful response"; this exception surfaces those cases.
class SplitwiseRequestFailedException extends SplitwiseException {
  /// Creates an exception for a failed-but-2xx response.
  SplitwiseRequestFailedException({
    required this.method,
    required this.uri,
    required this.errors,
  }) : super(
         'Splitwise reported failure for $method $uri'
         '${errors.isEmpty ? '' : ': $errors'}',
       );

  /// The HTTP method of the request.
  final String method;

  /// The URI of the request.
  final Uri uri;

  /// The errors reported by the API.
  final SplitwiseErrors errors;
}
