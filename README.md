# Splitwise API for Dart

[![pub package](https://img.shields.io/pub/v/splitwise_api.svg)](https://pub.dev/packages/splitwise_api)
[![CI](https://github.com/srthkpthk/splitwise_api/actions/workflows/ci.yml/badge.svg)](https://github.com/srthkpthk/splitwise_api/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/srthkpthk/splitwise_api/blob/master/LICENSE)
![GitHub stars](https://img.shields.io/github/stars/srthkpthk/splitwise_api)

A typed Dart client for the [Splitwise API v3.0](https://dev.splitwise.com),
generated from and tested against Splitwise's official OpenAPI specification.
Works in Dart and Flutter apps on every platform (no `dart:io`).

## Features

- OAuth 2.0 authorization-code flow and personal API keys
- Every documented endpoint (users, groups, friends, expenses, comments,
  notifications, currencies, categories) — verified by a test that fails if
  the spec and the client drift apart
- Typed request and response models with `fromJson`/`toJson`
- Failures surface as exceptions, including Splitwise's
  "200 OK but `success: false`" responses
- Injectable `http.Client` for testing
- Unknown enum values decode to `unknown` instead of throwing

> Upgrading from 2.x? See the [migration guide](CHANGELOG.md#300) — 3.0.0
> replaces OAuth 1.0 and the raw-string responses.

## Installation

```yaml
dependencies:
  splitwise_api: ^3.0.0
```

## Quick start with an API key

Generate a personal API key on your app's page at
<https://secure.splitwise.com/apps>. The key acts on your own account.

```dart
import 'package:splitwise_api/splitwise_api.dart';

Future<void> main() async {
  final client = SplitwiseClient.apiKey('YOUR_API_KEY');

  final me = await client.getCurrentUser();
  print('Hi ${me.firstName}!');

  final groups = await client.getGroups();
  final expenses = await client.getExpenses(groupId: groups.first.id, limit: 10);
  for (final expense in expenses) {
    print('${expense.description}: ${expense.cost} ${expense.currencyCode}');
  }

  client.close();
}
```

## OAuth 2.0

Use OAuth 2.0 to act on behalf of other users. Register an application at
<https://secure.splitwise.com/apps> to get a consumer key/secret and set its
callback URL.

```dart
final oauth = SplitwiseOAuth2(
  clientId: 'CONSUMER_KEY',
  clientSecret: 'CONSUMER_SECRET',
  redirectUri: Uri.parse('https://example.com/splitwise/callback'),
);

// 1. Send the user to the authorization page. Keep `state` (per session,
//    e.g. in the user's server-side session) to validate the callback.
final state = SplitwiseOAuth2.generateState();
final url = oauth.authorizationUrl(state: state);

// 2. Splitwise redirects to redirectUri?code=...&state=...
//    Reject the callback unless its state matches — this binds the response
//    to the request you started and blocks login CSRF.
if (callback.queryParameters['state'] != state) {
  throw StateError('OAuth state mismatch');
}
final token = await oauth.exchangeCode(callback.queryParameters['code']!);

// 3. Persist the token and use it.
await storage.write('splitwise_token', jsonEncode(token.toJson()));
final client = SplitwiseClient.accessToken(token.accessToken);
```

Restore a persisted token with `OAuth2Token.fromJson(jsonDecode(saved))`.
Splitwise does not document token expiry or refresh tokens; `OAuth2Token`
keeps `expiresAt`/`refreshToken` nullable in case that changes.

## API overview

| Area | Methods |
|---|---|
| Users | `getCurrentUser()`, `getUser(id)`, `updateUser(id, UpdateUserRequest)` |
| Groups | `getGroups()`, `getGroup(id)`, `createGroup(CreateGroupRequest)`, `deleteGroup(id)`, `undeleteGroup(id)`, `addUserToGroup(groupId:, userId:)`, `addUserToGroupByEmail(groupId:, email:, firstName:, lastName:)`, `removeUserFromGroup(groupId:, userId:)` |
| Friends | `getFriends()`, `getFriend(id)`, `createFriend(email:, …)`, `createFriends([NewFriend…])`, `deleteFriend(id)` |
| Expenses | `getExpense(id)`, `getExpenses(groupId:, friendId:, datedAfter:, datedBefore:, updatedAfter:, updatedBefore:, limit:, offset:)`, `createExpense(EqualGroupSplit | SplitByShares)`, `updateExpense(id, UpdateExpenseRequest)`, `deleteExpense(id)`, `undeleteExpense(id)` |
| Comments | `getComments(expenseId:)`, `createComment(expenseId:, content:)`, `deleteComment(id)` |
| Other | `getNotifications(updatedAfter:, limit:)`, `getCurrencies()`, `getCategories()` |

### Creating expenses

```dart
// Split equally between everyone in a group.
await client.createExpense(EqualGroupSplit(
  cost: '30.00',
  description: 'Groceries',
  groupId: group.id,
));

// Specify each person's share (amounts are decimal strings).
await client.createExpense(SplitByShares(
  cost: '30.00',
  description: 'Taxi',
  groupId: 0, // 0 = not in a group
  users: [
    ExpenseShareInput.user(userId: me.id, paidShare: '30.00', owedShare: '15.00'),
    ExpenseShareInput.user(userId: friend.id, paidShare: '0', owedShare: '15.00'),
  ],
));

// Change only what you pass.
await client.updateExpense(expense.id, UpdateExpenseRequest(description: 'Cab'));
```

## Error handling

```dart
try {
  await client.deleteExpense(id);
} on SplitwiseUnauthorizedException {
  // 401 — bad or revoked API key / token
} on SplitwiseNotFoundException catch (e) {
  print(e.errors); // e.g. "Invalid API request: record not found"
} on SplitwiseRequestFailedException catch (e) {
  // Splitwise answered 200 but reported failure, e.g. already deleted
  print(e.errors.byField); // {expense: [Expense has already been deleted]}
} on SplitwiseHttpException catch (e) {
  print('HTTP ${e.statusCode}');
}
```

All exceptions extend `SplitwiseException`. `SplitwiseRateLimitException`
(429) exposes `retryAfter` when the server sends one; the client does not
retry automatically.

## Request body encoding

Splitwise documents JSON request bodies and this package sends them by
default. If an endpoint rejects a JSON body you can switch to form encoding
(the encoding the Splitwise web app uses):

```dart
final client = SplitwiseClient.apiKey(key, bodyEncoding: BodyEncoding.formUrlEncoded);
```

`createFriends` is always form-encoded because the server does not accept
JSON for it.

## Testing your own code

Pass a `MockClient` from `package:http/testing.dart`:

```dart
final client = SplitwiseClient.apiKey('k', httpClient: MockClient((request) async {
  return http.Response(jsonEncode({'user': {'id': 1}}), 200);
}));
```

## Contributing

```sh
dart pub get
dart run build_runner build   # regenerate *.g.dart after editing models
dart format .
dart analyze
dart test                     # offline suite against the committed spec
SPLITWISE_API_KEY=... dart test --tags live   # optional: hits the real API
```

The live suite creates and deletes a throwaway group, expense and comment on
the key's own account and never touches other users.

## Resources

- [Splitwise API documentation](https://dev.splitwise.com)
- [Package on pub.dev](https://pub.dev/packages/splitwise_api)
- [GitHub repository](https://github.com/srthkpthk/splitwise_api)

## License

MIT — see [LICENSE](LICENSE).
