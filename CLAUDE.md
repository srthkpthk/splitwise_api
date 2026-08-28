# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`splitwise_api` is a pure-Dart package (no Flutter dependency, despite the Flutter-generated `.metadata`) published on pub.dev. It wraps the Splitwise REST API v3.0 using OAuth 1.0 (HMAC-SHA1) via the `oauth1` package. The whole library is three Dart files under `lib/`; there are deliberately **no data models** — every API method returns the raw JSON body as a `String` (or an `int` status code on failure) and callers parse it themselves.

Version and SDK constraint live in `pubspec.yaml` (currently `sdk: ">=2.12.0 <4.0.0"`); `CHANGELOG.md` is the release log. The install snippet in `README.md` lags behind the pubspec version.

## Commands

```bash
dart pub get                 # install deps
dart analyze                 # static analysis (see caveat below)
dart format .                # format; currently reflows splitwise_main.dart (verified on Dart 3.11.1)
dart pub publish --dry-run   # pana/publish validation without publishing
dart pub publish             # release (maintainer credentials required)
```

Caveats, all verified against the current tree:

- `dart analyze` currently exits non-zero with `include_file_not_found`: `analysis_options.yaml` includes `package:lints/core.yaml` but `lints` is not a dev dependency. Fix is `dart pub add --dev lints`.
- **There is no test suite.** No `test/` directory has ever existed and `package:test` is not a dependency. To add tests: `dart pub add --dev test`, create `test/`, then `dart test` (single file: `dart test test/foo_test.dart`).
- `json_serializable`, `json_annotation`, and `build_runner` are declared in `pubspec.yaml` but **nothing uses them** — no `@JsonSerializable`, no `part '*.g.dart'`, no `build.yaml`. Running `dart run build_runner build` generates nothing. Treat them as vestigial.

## Architecture

- `lib/splitwise_api.dart` — barrel file; exports the two classes below.
- `lib/src/util/auth/splitwise_main.dart` — `SplitWiseService`, the single class holding auth state and every endpoint method. Note it imports the barrel (`../../../splitwise_api.dart`) to reach `TokensHelper` rather than importing the helper directly.
- `lib/src/util/helper/tokens_helper.dart` — `TokensHelper`, an immutable `(token, tokenSecret)` pair with `fromMap`/`fromJSON`/`toJSON` for persistence. Storage is the caller's responsibility.

### Authentication: `validateClient()` is three methods in one

`SplitWiseService.initialize(consumerKey, consumerSecret)` only builds `oauth.ClientCredentials`/`oauth.Authorization`. `validateClient` then dispatches on its arguments and returns a different type from each branch (declared `Future<dynamic>`):

| Call | Does | Returns |
|---|---|---|
| `validateClient()` | requests a temporary token (`oob` callback), stores it in the instance field `url` | `String` authorization URL |
| `validateClient(verifier: code)` | exchanges the stored temporary token + verifier for access tokens, builds `_client` | `TokensHelper` |
| `validateClient(tokens: saved)` | rebuilds `_client` from persisted tokens | `oauth.Client` |

The verifier exchange reads the temporary credentials from `url`, so steps 1 and 2 must run on the **same `SplitWiseService` instance in the same process**. Only the third form works across restarts.

### Request pattern

`_makeGetRequest(path, {options})` and `_makePostRequest(path, {options})` in the "Method Utils" fold:

- Throw `Exception('Please use validateClient First')` if `_client` is null.
- Build `Uri.https('secure.splitwise.com', '/api/v3.0/$path', options)` — so `options` are **always query-string parameters, including for POST**. There is no request body.
- `print(t.body)` unconditionally on every response.
- Return `t.body` (`String`) when status is 200, otherwise `t.statusCode` (`int`). Callers must check the runtime type.

Endpoint methods are one-liners over these helpers, grouped by `//<editor-fold desc="...">` sections: Method Utils, Authorization, User, Group, Friends, Expenses, Comments, Notification, Currencies. Every public member carries dartdoc (pub.dev score depends on it) and an explicit return type (`always_declare_return_types` is enforced).

### Known-broken methods — do not copy these patterns

These are leftovers from the data classes removed in 2.0.2 and are still present; be aware of them when touching or extending the file.

- `deleteGroup`, `unDeleteGroup`, `addUserToGroup`, `removeUserFromGroup`, `deleteFriend`, `deleteExpense`, `unDeleteExpense` do `t.success! ? true : t.errors` on the helper result. The helper returns a `String` or `int`, so this throws `NoSuchMethodError` at runtime on any response. New endpoints should return the helper result directly (or decode the JSON and inspect `success`/`errors`).
- `updateUser` posts to the path `https://www.splitwise.comupdate_user/$id`, which is mangled — the correct path is `update_user/$id`.
- `addUserToGroup` and `removeUserFromGroup` accept `options` but never pass them to `_makePostRequest`.
- `createExpense` is `Future<void>` and discards the response, unlike every other method.

## Adding an endpoint

1. Put the method in the matching editor-fold section.
2. `Future<dynamic> name(...) async => _makeGetRequest('path', options: ...)` or `_makePostRequest(...)`; path is relative to `/api/v3.0/`.
3. Add dartdoc and keep the explicit return type, or `dart analyze` (once `lints` is installed) and pana will flag it.
4. Update `README.md`'s API Methods list.

## Releasing

Bump `version` in `pubspec.yaml`, add a `## [x.y.z] - <date>` entry at the top of `CHANGELOG.md`, update the README install snippet, then `dart pub publish --dry-run` before `dart pub publish`.

## Other notes

- `.serena/memories/*.md` are Serena MCP notes from an earlier session and are partly stale (they reference `TokensHelper.dart` and claim no `analysis_options.yaml` exists). Prefer this file and the source.
