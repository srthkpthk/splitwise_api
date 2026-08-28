import 'package:http/http.dart' as http;
import 'package:splitwise_api/splitwise_api.dart';
import 'package:splitwise_api/src/transport.dart';
import 'package:test/test.dart';

void main() {
  final uri = Uri.parse('https://secure.splitwise.com/api/v3.0/x');

  group('SplitwiseErrors.fromResponseJson', () {
    test('{error: str} (401 shape)', () {
      final errors = SplitwiseErrors.fromResponseJson({'error': 'nope'});
      expect(errors.byField, {
        'base': ['nope'],
      });
      expect(errors.messages, ['nope']);
    });

    test('{errors: {base: [..]}} (403/404 shape)', () {
      final errors = SplitwiseErrors.fromResponseJson({
        'errors': {
          'base': ['Invalid API request: record not found'],
        },
      });
      expect(errors.messages, ['Invalid API request: record not found']);
    });

    test('{errors: {field: [..]}} prefixes non-base fields', () {
      final errors = SplitwiseErrors.fromResponseJson({
        'errors': {
          'cost': ["can't be blank"],
          'base': ['bad'],
        },
      });
      expect(errors.messages, ["cost: can't be blank", 'bad']);
      expect(errors.toString(), "cost: can't be blank; bad");
    });

    test('{errors: [..]} (undelete_group shape)', () {
      final errors = SplitwiseErrors.fromResponseJson({
        'errors': ['a', 'b'],
      });
      expect(errors.messages, ['a', 'b']);
    });

    test('empty shapes are empty', () {
      for (final body in [
        {'errors': {}},
        {'errors': []},
        {'errors': null},
        {'success': true},
        <String, Object?>{},
        null,
        'html',
      ]) {
        expect(
          SplitwiseErrors.fromResponseJson(body).isEmpty,
          isTrue,
          reason: '$body',
        );
      }
    });

    test('scalar messages are tolerated', () {
      final errors = SplitwiseErrors.fromResponseJson({
        'errors': {'base': 'single'},
      });
      expect(errors.messages, ['single']);
    });
  });

  group('SplitwiseHttpException.forStatus', () {
    SplitwiseHttpException build(int status, {Object? json, String? retry}) =>
        SplitwiseHttpException.forStatus(
          statusCode: status,
          method: 'GET',
          uri: uri,
          body: '',
          json: json,
          retryAfterHeader: retry,
        );

    test('maps documented statuses to subclasses', () {
      expect(build(400), isA<SplitwiseBadRequestException>());
      expect(build(401), isA<SplitwiseUnauthorizedException>());
      expect(build(403), isA<SplitwiseForbiddenException>());
      expect(build(404), isA<SplitwiseNotFoundException>());
      expect(build(429), isA<SplitwiseRateLimitException>());
      expect(build(500).runtimeType, SplitwiseHttpException);
    });

    test('parses Retry-After seconds and tolerates garbage', () {
      final limited = build(429, retry: '30') as SplitwiseRateLimitException;
      expect(limited.retryAfter, const Duration(seconds: 30));
      final unknown =
          build(429, retry: 'Wed, 21 Oct 2015 07:28:00 GMT')
              as SplitwiseRateLimitException;
      expect(unknown.retryAfter, isNull);
    });

    test('message includes status, method, uri and errors', () {
      final e = build(
        403,
        json: {
          'errors': {
            'base': ['no'],
          },
        },
      );
      expect(e.message, 'HTTP 403 for GET $uri: no');
      expect(e.toString(), startsWith('SplitwiseForbiddenException:'));
    });
  });

  group('SplitwiseTransport.decodeResponse', () {
    Map<String, dynamic> decode(
      String body, {
      int status = 200,
      Map<String, String> headers = const {},
    }) => SplitwiseTransport.decodeResponse(
      http.Response(body, status, headers: headers),
      method: 'POST',
      uri: uri,
    );

    test('returns the JSON object for a clean 2xx', () {
      expect(decode('{"group":{"id":1}}'), {
        'group': {'id': 1},
      });
      expect(decode('{"success":true,"errors":{}}', status: 201), isNotEmpty);
    });

    test('success:false throws SplitwiseRequestFailedException', () {
      expect(
        () => decode('{"success":false}'),
        throwsA(isA<SplitwiseRequestFailedException>()),
      );
    });

    test('non-empty errors on 200 throws with the errors attached', () {
      expect(
        () => decode('{"expenses":[],"errors":{"base":["bad"]}}'),
        throwsA(
          isA<SplitwiseRequestFailedException>().having(
            (e) => e.errors.messages,
            'messages',
            ['bad'],
          ),
        ),
      );
    });

    test('HTML 404 becomes SplitwiseNotFoundException with the raw body', () {
      expect(
        () => decode('<html>404</html>', status: 404),
        throwsA(
          isA<SplitwiseNotFoundException>()
              .having((e) => e.body, 'body', '<html>404</html>')
              .having((e) => e.errors.isEmpty, 'no errors', isTrue),
        ),
      );
    });

    test('429 carries retry-after', () {
      expect(
        () => decode('', status: 429, headers: {'retry-after': '5'}),
        throwsA(
          isA<SplitwiseRateLimitException>().having(
            (e) => e.retryAfter,
            'retryAfter',
            const Duration(seconds: 5),
          ),
        ),
      );
    });

    test('a 2xx that is not a JSON object throws SplitwiseException', () {
      expect(() => decode('[]'), throwsA(isA<SplitwiseException>()));
      expect(() => decode('oops'), throwsA(isA<SplitwiseException>()));
      expect(() => decode(''), throwsA(isA<SplitwiseException>()));
    });
  });

  test('formFields stringifies and drops nulls', () {
    expect(
      SplitwiseTransport.formFields({'a': 1, 'b': true, 'c': null, 'd': 'x'}),
      {'a': '1', 'b': 'true', 'd': 'x'},
    );
  });

  test('normalizeBaseUrl appends a slash once', () {
    expect(
      SplitwiseTransport.normalizeBaseUrl(Uri.parse('https://h/api/v3.0')).path,
      '/api/v3.0/',
    );
    expect(
      SplitwiseTransport.normalizeBaseUrl(
        Uri.parse('https://h/api/v3.0/'),
      ).path,
      '/api/v3.0/',
    );
  });
}
