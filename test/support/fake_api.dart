import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:splitwise_api/splitwise_api.dart';
import 'package:test/test.dart';

/// A [SplitwiseClient] wired to an in-memory HTTP server that records every
/// request and answers with a canned body.
class FakeApi {
  /// Creates a fake API.
  ///
  /// [respond] is JSON-encoded as the response body unless [responder] (which
  /// receives the request) or [rawBody] is given.
  FakeApi({
    Object? respond = const <String, Object?>{},
    Object? Function(http.Request request)? responder,
    String? rawBody,
    int status = 200,
    Map<String, String> headers = const {},
    Uri? baseUrl,
    BodyEncoding bodyEncoding = BodyEncoding.json,
    String apiKey = 'TEST_KEY',
  }) {
    final mock = MockClient((request) async {
      requests.add(request);
      final body = rawBody ?? jsonEncode(responder?.call(request) ?? respond);
      return http.Response(
        body,
        status,
        headers: {
          'content-type': 'application/json; charset=utf-8',
          ...headers,
        },
        request: request,
      );
    });
    client = SplitwiseClient.apiKey(
      apiKey,
      httpClient: mock,
      baseUrl: baseUrl,
      bodyEncoding: bodyEncoding,
    );
  }

  /// Every request received, in order.
  final requests = <http.Request>[];

  /// The client under test.
  late final SplitwiseClient client;

  /// The most recent request.
  http.Request get lastRequest => requests.last;
}

/// Asserts the shape of a recorded [request].
///
/// [path] is the full URL path (for example `/api/v3.0/get_groups`).
/// [query] is compared exactly when given. [jsonBody] is compared against the
/// decoded request body and also asserts a JSON content type; [formBody]
/// asserts a form-encoded body instead.
void expectRequest(
  http.Request request, {
  required String method,
  required String path,
  Map<String, String>? query,
  Map<String, Object?>? jsonBody,
  Map<String, String>? formBody,
  String bearer = 'TEST_KEY',
}) {
  expect(request.method, method);
  expect(request.url.host, 'secure.splitwise.com');
  expect(request.url.path, path);
  expect(request.headers['authorization'], 'Bearer $bearer');
  expect(request.headers['accept'], 'application/json');
  if (query != null) {
    expect(request.url.queryParameters, query);
  }
  if (jsonBody != null) {
    expect(request.headers['content-type'], startsWith('application/json'));
    expect(jsonDecode(request.body), jsonBody);
  }
  if (formBody != null) {
    expect(
      request.headers['content-type'],
      startsWith('application/x-www-form-urlencoded'),
    );
    expect(request.bodyFields, formBody);
  }
  if (method == 'GET') {
    expect(request.body, isEmpty);
  }
}
