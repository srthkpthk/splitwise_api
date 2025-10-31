# Splitwise API for Dart

[![pub package](https://img.shields.io/pub/v/splitwise_api.svg)](https://pub.dev/packages/splitwise_api)
[![License](https://img.shields.io/badge/license-MIT-orange.svg)](https://github.com/srthkpthk/splitwise_api/blob/master/LICENSE)
![GitHub stars](https://img.shields.io/github/stars/srthkpthk/splitwise_api)

A Dart wrapper for the [Splitwise API v3.0](https://dev.splitwise.com). Easily integrate Splitwise functionality into your Dart or Flutter applications.

## Features

- ✅ OAuth 1.0 authentication
- ✅ Full null-safety support
- ✅ Complete API coverage (users, groups, friends, expenses, comments, notifications)
- ✅ Simple and intuitive interface
- ✅ Lightweight with minimal dependencies

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  splitwise_api: ^2.0.3
```

Then run:

```bash
dart pub get
```

## Getting Started

### 1. Register Your Application

Get your `consumerKey` and `consumerSecret` from [Splitwise Apps](https://secure.splitwise.com/apps).

### 2. Import the Package

```dart
import 'package:splitwise_api/splitwise_api.dart';
```

### 3. Authentication Flow

The package uses OAuth 1.0 for authentication. Here's the complete flow:

```dart
// Initialize the service
SplitWiseService splitWiseService = SplitWiseService.initialize(
  'YOUR_CONSUMER_KEY',
  'YOUR_CONSUMER_SECRET',
);

// Step 1: Get authorization URL
var authURL = await splitWiseService.validateClient();
print('Please authorize at: $authURL');

// Step 2: After user authorizes, exchange verifier for tokens
TokensHelper tokens = await splitWiseService.validateClient(
  verifier: 'VERIFIER_CODE_FROM_USER',
);

// Save tokens for future use (see Token Persistence section)
await saveTokens(tokens);

// Step 3: Use the authenticated client
var currentUser = await splitWiseService.getCurrentUser();
print(currentUser);
```

### 4. Subsequent Sessions

For users who have already authenticated:

```dart
// Initialize service
SplitWiseService splitWiseService = SplitWiseService.initialize(
  'YOUR_CONSUMER_KEY',
  'YOUR_CONSUMER_SECRET',
);

// Load saved tokens
TokensHelper savedTokens = await loadTokens();

// Validate with saved tokens
await splitWiseService.validateClient(tokens: savedTokens);

// Ready to make API calls
var user = await splitWiseService.getCurrentUser();
```

## Token Persistence

You must implement token storage yourself. Here's an example using `shared_preferences`:

```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitwise_api/splitwise_api.dart';

class TokenStorage {
  static const _tokenKey = 'splitwise_token';
  static const _tokenSecretKey = 'splitwise_token_secret';

  Future<void> saveTokens(TokensHelper tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, tokens.token ?? '');
    await prefs.setString(_tokenSecretKey, tokens.tokenSecret ?? '');
  }

  Future<TokensHelper?> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final tokenSecret = prefs.getString(_tokenSecretKey);

    if (token == null || tokenSecret == null) return null;
    return TokensHelper(token, tokenSecret);
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_tokenSecretKey);
  }
}
```

## API Methods

### Users
```dart
await splitWiseService.getCurrentUser();
await splitWiseService.getUser(userId);
await splitWiseService.updateUser(userId, options);
```

### Groups
```dart
await splitWiseService.getGroups();
await splitWiseService.getGroup(groupId);
await splitWiseService.createGroup(options);
await splitWiseService.deleteGroup(groupId);
await splitWiseService.addUserToGroup(options);
await splitWiseService.removeUserFromGroup(options);
```

### Friends
```dart
await splitWiseService.getFriends();
await splitWiseService.getFriend(friendId);
await splitWiseService.createFriend(options);
await splitWiseService.createFriends(options);
await splitWiseService.deleteFriend(friendId);
```

### Expenses
```dart
await splitWiseService.getExpenses(options: filters);
await splitWiseService.getExpense(expenseId);
await splitWiseService.createExpense(options);
await splitWiseService.updateExpense(expenseId, options);
await splitWiseService.deleteExpense(expenseId);
```

### Comments
```dart
await splitWiseService.getComments(expenseId);
await splitWiseService.createComment(options);
await splitWiseService.deleteComment(commentId);
```

### Other
```dart
await splitWiseService.getNotifications(options: filters);
await splitWiseService.getCurrencies();
await splitWiseService.getCategories();
await splitWiseService.parseSentence(options);
```

## Important Notes

- **No Data Models**: This package returns raw JSON responses. You'll need to parse them yourself or create your own model classes.
- **OAuth 1.0**: This package uses OAuth 1.0, not OAuth 2.0.
- **Error Handling**: Methods return status codes on failure. Implement proper error handling in your application.

## Example

See the [example](example/example.dart) directory for a complete working example.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an Issue.

## Resources

- [Splitwise API Documentation](https://dev.splitwise.com)
- [Package on pub.dev](https://pub.dev/packages/splitwise_api)
- [GitHub Repository](https://github.com/srthkpthk/splitwise_api)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 

