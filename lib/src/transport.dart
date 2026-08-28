import 'dart:convert';

import 'package:http/http.dart' as http;

import 'exceptions.dart';

/// How request bodies are encoded for `POST` calls.
enum BodyEncoding {
  /// `application/json`, as documented in the Splitwise OpenAPI spec.
  json,

  /// `application/x-www-form-urlencoded`, the encoding used by the Splitwise
  /// web app itself. Use this if a JSON body is rejected for an endpoint.
  formUrlEncoded,
}

/// Low-level HTTP layer used by `SplitwiseClient`: adds the bearer token,
/// encodes bodies, decodes JSON and converts failures into exceptions.
///
/// Not exported from the package.
class SplitwiseTransport {
  /// Creates a transport.
  ///
  /// [baseUrl] is normalised to end with `/` so that relative paths resolve
  /// underneath it. When [httpClient] is `null` an [http.Client] is created
  /// and owned by this transport.
  SplitwiseTransport({
    required String bearerToken,
    required Uri baseUrl,
    http.Client? httpClient,
    this.bodyEncoding = BodyEncoding.json,
  }) : _bearerToken = bearerToken,
       baseUrl = normalizeBaseUrl(baseUrl),
       _client = httpClient ?? http.Client(),
       _ownsClient = httpClient == null;

  /// Ensures [uri] ends with a trailing slash so [Uri.resolve] keeps its path.
  static Uri normalizeBaseUrl(Uri uri) =>
      uri.path.endsWith('/') ? uri : uri.replace(path: '${uri.path}/');

  /// Base URL every path is resolved against; always ends with `/`.
  final Uri baseUrl;

  /// Default encoding for `POST` bodies.
  final BodyEncoding bodyEncoding;

  final String _bearerToken;
  final http.Client _client;
  final bool _ownsClient;

  /// Sends a `GET` request and returns the decoded JSON object.
  ///
  /// `null` values in [query] are omitted.
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String?> query = const {},
  }) => _send('GET', path, query: query);

  /// Sends a `POST` request with [body] and returns the decoded JSON object.
  ///
  /// [encoding] overrides [bodyEncoding] for this call.
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, Object?> body = const {},
    BodyEncoding? encoding,
  }) => _send('POST', path, body: body, encoding: encoding);

  /// Releases the underlying [http.Client] if this transport created it.
  void close() {
    if (_ownsClient) {
      _client.close();
    }
  }

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Map<String, String?> query = const {},
    Map<String, Object?>? body,
    BodyEncoding? encoding,
  }) async {
    var uri = baseUrl.resolve(path);
    final queryParameters = {
      for (final entry in query.entries)
        if (entry.value != null) entry.key: entry.value!,
    };
    if (queryParameters.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParameters);
    }

    final request = http.Request(method, uri)
      ..headers['Accept'] = 'application/json'
      ..headers['Authorization'] = 'Bearer $_bearerToken';

    if (body != null) {
      switch (encoding ?? bodyEncoding) {
        case BodyEncoding.json:
          request
            ..headers['Content-Type'] = 'application/json'
            ..body = jsonEncode(body);
        case BodyEncoding.formUrlEncoded:
          request.bodyFields = formFields(body);
      }
    }

    final response = await http.Response.fromStream(
      await _client.send(request),
    );
    return decodeResponse(response, method: method, uri: uri);
  }

  /// Converts a JSON-style [body] into string form fields, dropping `null`s.
  static Map<String, String> formFields(Map<String, Object?> body) => {
    for (final entry in body.entries)
      if (entry.value != null) entry.key: entry.value.toString(),
  };

  /// Validates [response] and returns its decoded JSON object.
  ///
  /// Throws a [SplitwiseHttpException] subclass for non-2xx statuses and a
  /// [SplitwiseRequestFailedException] when a 2xx body reports
  /// `"success": false` or carries a non-empty `errors` member.
  static Map<String, dynamic> decodeResponse(
    http.Response response, {
    required String method,
    required Uri uri,
  }) {
    final json = tryDecodeJson(response.body);
    final status = response.statusCode;

    if (status < 200 || status >= 300) {
      throw SplitwiseHttpException.forStatus(
        statusCode: status,
        method: method,
        uri: uri,
        body: response.body,
        json: json,
        retryAfterHeader: response.headers['retry-after'],
      );
    }

    if (json is! Map<String, dynamic>) {
      throw SplitwiseException(
        'Expected a JSON object from $method $uri but got: '
        '${_preview(response.body)}',
      );
    }

    final errors = SplitwiseErrors.fromResponseJson(json);
    if (json['success'] == false || errors.isNotEmpty) {
      throw SplitwiseRequestFailedException(
        method: method,
        uri: uri,
        errors: errors,
      );
    }
    return json;
  }

  /// Decodes [body] as JSON, returning `null` if it is not valid JSON.
  static Object? tryDecodeJson(String body) {
    if (body.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(body);
    } on FormatException {
      return null;
    }
  }

  static String _preview(String body) =>
      body.length <= 120 ? body : '${body.substring(0, 120)}…';
}
