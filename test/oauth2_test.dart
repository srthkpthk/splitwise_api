import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:splitwise_api/splitwise_api.dart';
import 'package:test/test.dart';

void main() {
  final redirect = Uri.parse('https://example.com/cb?x=1');

  SplitwiseOAuth2 oauth({required http.Client httpClient, Uri? baseUrl}) =>
      SplitwiseOAuth2(
        clientId: 'CLIENT',
        clientSecret: 'SECRET',
        redirectUri: redirect,
        httpClient: httpClient,
        oauthBaseUrl: baseUrl,
      );

  test(
    'authorizationUrl targets www.splitwise.com with the RFC parameters',
    () {
      final url = oauth(
        httpClient: MockClient((_) async => http.Response('', 200)),
      ).authorizationUrl(state: 'xyz');
      expect(url.scheme, 'https');
      expect(url.host, 'www.splitwise.com');
      expect(url.path, '/oauth/authorize');
      expect(url.queryParameters, {
        'response_type': 'code',
        'client_id': 'CLIENT',
        'redirect_uri': redirect.toString(),
        'state': 'xyz',
      });
    },
  );

  test('authorizationUrl omits state when not given', () {
    final url = oauth(
      httpClient: MockClient((_) async => http.Response('', 200)),
    ).authorizationUrl();
    expect(url.queryParameters.containsKey('state'), isFalse);
  });

  test('exchangeCode posts a form-encoded authorization_code grant', () async {
    late http.Request seen;
    final client = MockClient((request) async {
      seen = request;
      return http.Response(
        jsonEncode({'access_token': 'tok', 'token_type': 'bearer'}),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

    final token = await oauth(httpClient: client).exchangeCode('CODE');

    expect(seen.method, 'POST');
    expect(seen.url.toString(), 'https://www.splitwise.com/oauth/token');
    expect(seen.headers['accept'], 'application/json');
    expect(
      seen.headers['content-type'],
      startsWith('application/x-www-form-urlencoded'),
    );
    expect(seen.bodyFields, {
      'grant_type': 'authorization_code',
      'client_id': 'CLIENT',
      'client_secret': 'SECRET',
      'code': 'CODE',
      'redirect_uri': redirect.toString(),
    });
    expect(token.accessToken, 'tok');
    expect(token.tokenType, 'bearer');
  });

  test(
    'an HTML 404 becomes SplitwiseOAuth2Exception, not FormatException',
    () async {
      final client = MockClient(
        (_) async => http.Response('<html><title>404</title></html>', 404),
      );
      await expectLater(
        oauth(httpClient: client).exchangeCode('CODE'),
        throwsA(
          isA<SplitwiseOAuth2Exception>()
              .having((e) => e.statusCode, 'statusCode', 404)
              .having((e) => e.error, 'error', isNull)
              .having((e) => e.body, 'body', contains('404')),
        ),
      );
    },
  );

  test('an RFC error body is parsed', () async {
    final client = MockClient(
      (_) async => http.Response(
        jsonEncode({
          'error': 'invalid_grant',
          'error_description': 'The code has expired',
        }),
        400,
      ),
    );
    await expectLater(
      oauth(httpClient: client).exchangeCode('CODE'),
      throwsA(
        isA<SplitwiseOAuth2Exception>()
            .having((e) => e.error, 'error', 'invalid_grant')
            .having(
              (e) => e.errorDescription,
              'description',
              'The code has expired',
            )
            .having((e) => e.message, 'message', contains('invalid_grant')),
      ),
    );
  });

  test('a 200 without access_token is rejected', () async {
    final client = MockClient(
      (_) async => http.Response(jsonEncode({'token_type': 'bearer'}), 200),
    );
    await expectLater(
      oauth(httpClient: client).exchangeCode('CODE'),
      throwsA(isA<SplitwiseOAuth2Exception>()),
    );
  });

  test('a custom base URL without a trailing slash still resolves', () async {
    late Uri seen;
    final client = MockClient((request) async {
      seen = request.url;
      return http.Response(jsonEncode({'access_token': 't'}), 200);
    });
    await oauth(
      httpClient: client,
      baseUrl: Uri.parse('https://secure.splitwise.com'),
    ).exchangeCode('CODE');
    expect(seen.toString(), 'https://secure.splitwise.com/oauth/token');
  });
}
