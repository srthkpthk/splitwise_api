## [3.0.0] - 2026-08-28

Complete rewrite against Splitwise's official OpenAPI 3.0.1 specification.
**This release is not backwards compatible.**

### Breaking changes

* **Authentication is now OAuth 2.0 or a personal API key.** OAuth 1.0 and
  the `oauth1` dependency are gone. Existing OAuth 1.0 tokens cannot be
  converted; users must authorize again. The consumer key/secret from
  <https://secure.splitwise.com/apps> is reused as the OAuth 2.0 client
  ID/secret.
* **Typed models instead of raw strings.** Every method returns a model
  (`CurrentUser`, `Group`, `Expense`, …) or `void`; nothing returns a JSON
  `String` or an `int` status code any more.
* **Failures are exceptions.** Non-2xx responses throw
  `SplitwiseHttpException` (with `SplitwiseBadRequestException`,
  `SplitwiseUnauthorizedException`, `SplitwiseForbiddenException`,
  `SplitwiseNotFoundException`, `SplitwiseRateLimitException`); a 200 that
  reports `success: false` or non-empty `errors` throws
  `SplitwiseRequestFailedException`.
* **POST parameters are sent as a JSON body** instead of query-string
  parameters. `BodyEncoding.formUrlEncoded` is available as an escape hatch;
  `createFriends` always uses it.
* `parseSentence` was removed: `parse_sentence` is no longer part of the
  Splitwise API.
* Minimum Dart SDK is 3.9.
* The unconditional `print` of every response body was removed.
* `SplitwiseNotification` and `SplitwiseCategory` are named to avoid clashing
  with Flutter's `Notification` and `Category`.

### Migration from 2.x

| 2.x | 3.x |
|---|---|
| `SplitWiseService.initialize(key, secret)` | `SplitwiseClient.apiKey(apiKey)` or `SplitwiseOAuth2(clientId:, clientSecret:, redirectUri:)` |
| `validateClient()` → auth URL | `SplitwiseOAuth2.authorizationUrl(state:)` |
| `validateClient(verifier:)` → `TokensHelper` | `SplitwiseOAuth2.exchangeCode(code)` → `OAuth2Token` |
| `validateClient(tokens:)` | `SplitwiseClient.accessToken(token.accessToken)` |
| `TokensHelper.toJSON()` / `fromJSON()` | `OAuth2Token.toJson()` / `OAuth2Token.fromJson()` |
| `getCurrentUser()` → `String` | `getCurrentUser()` → `CurrentUser` |
| `updateUser(id, Map)` | `updateUser(id, UpdateUserRequest(...))` |
| `createGroup(Map)` | `createGroup(CreateGroupRequest(name:, ...))` |
| `unDeleteGroup(id)` | `undeleteGroup(id)` |
| `addUserToGroup(Map)` | `addUserToGroup(groupId:, userId:)` or `addUserToGroupByEmail(groupId:, email:, firstName:, lastName:)` |
| `removeUserFromGroup(Map)` | `removeUserFromGroup(groupId:, userId:)` |
| `createFriend(Map)` | `createFriend(email:, firstName:, lastName:)` |
| `createFriends(Map)` | `createFriends([NewFriend(email:, ...)])` |
| `getExpenses(options: Map)` | `getExpenses(groupId:, friendId:, datedAfter:, ..., limit:, offset:)` |
| `createExpense(Map)` | `createExpense(EqualGroupSplit(...))` or `createExpense(SplitByShares(...))` |
| `updateExpense(id, Map)` | `updateExpense(id, UpdateExpenseRequest(...))` |
| `unDeleteExpense(id)` | `undeleteExpense(id)` |
| `getComments(int)` | `getComments(expenseId:)` |
| `createComment(Map)` | `createComment(expenseId:, content:)` |
| `getNotifications(options: Map)` | `getNotifications(updatedAfter:, limit:)` |
| `parseSentence(Map)` | removed |
| `t.success` / `t.errors` checks | catch `SplitwiseRequestFailedException` |

### Fixed

* `deleteGroup`, `unDeleteGroup`, `addUserToGroup`, `removeUserFromGroup`,
  `deleteFriend`, `deleteExpense` and `unDeleteExpense` threw
  `NoSuchMethodError` at runtime (they inspected `.success` on a `String`).
* `updateUser` posted to a malformed URL.
* `addUserToGroup` and `removeUserFromGroup` ignored their arguments.
* `createExpense` discarded the response.
* `dart analyze` failed because `lints` was not a dev dependency.

### Added

* Test suite: offline tests against the committed OpenAPI document
  (`spec/openapi.json`), including a coverage test that fails if any
  documented operation lacks a client method, plus an opt-in live suite
  (`SPLITWISE_API_KEY=... dart test --tags live`).
* `SplitwiseClient(httpClient:)` for injecting an `http.Client`.

### Notes on the specification

* `create_friend`'s schema lists `email` as required but the property is
  named `user_email`; this package sends `user_email`.
* `create_group`'s description documents `users__{i}__user_id` while its
  example shows `users__{i}__id`; this package sends `user_id`.
* The OAuth 2.0 endpoints are resolved against `https://www.splitwise.com/`
  (the host used by the Splitwise web app and other SDKs) and can be
  overridden with `SplitwiseOAuth2(oauthBaseUrl:)`.

## [2.0.5] - Nov 01 2025
* Added explicit return type annotations to all 31 methods
* Added analysis_options.yaml with lints_core package
* Fixed all linting issues to achieve perfect static analysis (50/50 points)
* Now fully compliant with Pana analysis requirements

## [2.0.4] - Nov 01 2025
* Updated dependencies to latest versions
* Fixed unused import warning in test file
* Achieved perfect pub.dev score (160/160 points)
* All static analysis checks passing

## [2.0.3] - Sep 26 2k21
* Versioning Error

## [2.0.2] - Sep 26 2k21
* Fixed some null-safety induced bugs
* Removed Data Classes

## [2.0.1] - May 31 2k21
* Migrated to null-safety
* Changed the Data Classes

## [2.0.0] - July 10 2k20
* Major BugFix

## [1.0.2] - July 09 2k20
* Minor BugFix

## [1.0.1] - July 09 2k20
* Added Data Class
* Added Token Helper

## [1.0.0] - July 03 2k20
* Fixed Comments and first Release

## [0.0.3] - June 30 2k20
* BugFix and added Comments

## [0.0.2 ] - June 29 2k20
* BugFix and README update

## [0.0.1] - June 29 2k20
* Added all methods
* No data classes as of now
* Some bugs that need to be fixed
