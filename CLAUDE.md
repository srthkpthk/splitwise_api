# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`splitwise_api` is a pure-Dart package (no Flutter or `dart:io` dependency in `lib/`) published on pub.dev. It is a typed client for the Splitwise REST API v3.0, built against Splitwise's official OpenAPI 3.0.1 document, a copy of which lives at `spec/openapi.json` and is the source of truth for endpoints, parameters and models. Authentication is a Bearer token: either a personal API key or an OAuth 2.0 access token obtained through the authorization-code flow.

Version and SDK constraint live in `pubspec.yaml` (`sdk: ^3.9.0`, set by the runtime dependency `json_annotation`); `CHANGELOG.md` is the release log and carries the 2.x→3.x migration table.

## Commands

```bash
dart pub get
dart run build_runner build      # regenerate lib/src/models/*.g.dart after editing an annotated model
dart format .                    # run after build_runner; source_gen's formatter can differ from the SDK's
dart analyze                     # must report "No issues found!"
dart test                        # offline suite (~170 tests) against spec/openapi.json; the live suite is skipped
SPLITWISE_API_KEY=... dart test --tags live   # opt-in: real API; run a single file with dart test test/client_test.dart
dart pub publish --dry-run       # pana/publish validation
```

Notes:
- `build_runner` ≥ 2.15 removed `--delete-conflicting-outputs`; passing it prints a warning and is ignored.
- `pubspec.lock` is intentionally untracked (library package).
- `spec/`, `build.yaml`, `CLAUDE.md`, `.serena/` and `.metadata` are excluded from the pub tarball via `.pubignore`.

## Architecture

```
lib/splitwise_api.dart               barrel; exports everything public (BodyEncoding is re-exported from transport)
lib/src/splitwise_client.dart        SplitwiseClient — one method per spec operation, grouped by tag
lib/src/transport.dart               SplitwiseTransport (internal): bearer header, JSON/form bodies, decode, error mapping
lib/src/exceptions.dart              SplitwiseException hierarchy + SplitwiseErrors
lib/src/auth/splitwise_oauth2.dart   SplitwiseOAuth2: authorizationUrl(), exchangeCode()
lib/src/auth/oauth2_token.dart       OAuth2Token (hand-written JSON)
lib/src/models/*.dart (+ *.g.dart)   response models, json_serializable; enums.dart holds every enum
lib/src/models/requests/*.dart       request payloads, hand-written toJson (sealed classes, flattened keys)
build.yaml                           json_serializable defaults: snake_case, explicit_to_json, include_if_null=false, date_time_utc
```

### Request / response flow

`SplitwiseClient` methods call `SplitwiseTransport.get/post` with a path relative to `https://secure.splitwise.com/api/v3.0/` (base URL is normalised to end with `/` so `Uri.resolve` keeps `v3.0`). The transport:

- sends `Accept: application/json` and `Authorization: Bearer …`;
- encodes POST bodies as JSON by default (`BodyEncoding.json`, typed bools/ints) or form-urlencoded (`BodyEncoding.formUrlEncoded`, everything stringified, nulls dropped). `createFriends` forces form encoding because Splitwise rejects JSON for it;
- turns non-2xx into `SplitwiseHttpException.forStatus(...)` (400/401/403/404/429 subclasses; non-JSON bodies keep the raw `body`);
- throws `SplitwiseRequestFailedException` when a 2xx body has `success: false` or a non-empty `errors` member — Splitwise documents that "200 OK does not indicate a successful response" for the delete/undelete/add/remove/create_expense family. Client methods therefore never inspect `success` themselves.

`SplitwiseErrors.fromResponseJson` normalises every error shape the spec uses (`{error: str}`, `{errors: {field: [..]}}`, `{errors: [..]}`, empty) into `byField` / `messages`.

### Model conventions

- No response schema in the spec declares `required`, so: `id` is non-null, every `List` is non-null with a `const []` default, everything else is nullable. Models must accept `{'id': 1}` (the test suite checks this).
- Inheritance via `extends` (`CurrentUser`, `Friend`, `GroupMember` extend `User`; `SplitwiseParentCategory` extends `SplitwiseCategory`). json_serializable includes superclass fields only if they are passed through `super.x` constructor parameters and the subclass has its own `@JsonSerializable`, `fromJson` and `@override toJson`. A file whose generated part references inherited types must import them (e.g. `friend.dart` imports `enums.dart` and `image_set.dart`).
- Enums carry a `wireName` (`@JsonEnum(valueField: 'wireName')`) and end in `unknown`; fields use `@JsonKey(unknownEnumValue: X.unknown)`. Hand-written request `toJson` uses `.wireName`.
- `ImageSet` serves every picture/avatar/cover-photo object; `SplitwiseCategory` serves both `get_categories` entries and `expense.category`.
- Names avoid Flutter collisions: `SplitwiseNotification`, `SplitwiseCategory`.
- Money is `String` (decimal strings per the spec); `date-time` fields are `DateTime` and re-emit as UTC ISO-8601 with milliseconds.
- Request classes with `users__{i}__{prop}` keys (`SplitByShares`, `UpdateExpenseRequest`, `CreateGroupRequest`, `createFriends`) go through `flattenUsers` in `requests/flatten.dart`. `CreateExpenseRequest`, `ExpenseShareInput` and `GroupMemberInput` are sealed.

### Adding or changing an endpoint

1. Check `spec/openapi.json` for the path, parameters, body and 200 schema.
2. Add the method to the matching section of `SplitwiseClient`; return the typed payload via `_object`/`_list`, or `void` for `{success}` responses.
3. Add it to the invoker table in `test/spec_coverage_test.dart` — that test asserts a bijection between public `Future<…>` methods, the invoker table and `spec.paths`, so it fails until you do.
4. Add a request-shape test in `test/client_test.dart` (method, path, query, body, parsed result) using `FakeApi` and `okResponseExample`.
5. If a new model is needed: add it under `lib/src/models/`, export it from `models.dart`, run `dart run build_runner build`, `dart format .`, and register it in the `cases` table of `test/models_test.dart`.

## Tests

- `test/support/spec_examples.dart` loads the spec, resolves `$ref`, merges `allOf` property-by-property, and synthesises example JSON (`exampleOf`, `okResponseExample`) from the spec's `example` values.
- `test/models_test.dart` — every model: parses the spec example, accepts a minimal object, serialises only documented keys, round-trips.
- `test/requests_test.dart` — flattened keys match the spec exactly; nulls omitted.
- `test/client_test.dart` — every operation's method/path/query/headers/body against `MockClient`; transport behaviours (trailing slash, form encoding, error mapping).
- `test/spec_coverage_test.dart` — spec ↔ client bijection.
- `test/oauth2_test.dart`, `test/exceptions_test.dart`.
- `test/live/live_api_test.dart` (tag `live`) — real API; creates and deletes a throwaway group/expense/comment on the key's own account and never calls endpoints that email or mutate other users.

## Things that are not verified against the live API

Without a registered OAuth app and a real key these remain mock-tested only; keep the caveats in `README.md`/`CHANGELOG.md` accurate if you learn more:
- The OAuth 2.0 token exchange (`www.splitwise.com/oauth/token`, credentials in the form body, `redirect_uri` required). The spec's relative URLs resolve to `secure.splitwise.com`; both hosts return an HTML 404 for an unknown `client_id`.
- JSON bodies for endpoints the live suite does not exercise (`create_friend`, `update_user`, `add_user_to_group*`, `remove_user_from_group`, `delete_friend`), and the real `errors` shapes on those.
- `update_user`'s response, which the spec documents unwrapped; the client accepts both wrapped and unwrapped.

## Releasing

Bump `version` in `pubspec.yaml`, add a `## [x.y.z] - YYYY-MM-DD` entry at the top of `CHANGELOG.md`, update the README install snippet, run the full command list above, then `dart pub publish`.
