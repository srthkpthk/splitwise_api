# Codebase Structure

## Directory Layout
```
splitwise_api/
├── lib/
│   ├── splitwise_api.dart          # Package entry point (exports)
│   └── src/
│       └── util/
│           ├── auth/
│           │   └── splitwise_main.dart    # SplitWiseService (main API wrapper)
│           └── helper/
│               └── TokensHelper.dart      # OAuth token data class
├── example/
│   └── example.dart                # Usage example
├── pubspec.yaml                    # Package configuration
├── CHANGELOG.md                    # Version history
├── LICENSE                         # MIT License
├── README.md                       # Package documentation
└── CLAUDE.md                       # Claude Code guidance
```

## Key Files

### `lib/splitwise_api.dart`
- Package entry point
- Exports `SplitWiseService` and `TokensHelper`
- Uses editor fold comments for organization

### `lib/src/util/auth/splitwise_main.dart`
- **SplitWiseService** class (~230 lines)
- Contains all API endpoint methods
- Manages OAuth 1.0 authentication flow
- Internal HTTP request helpers: `_makeGetRequest()`, `_makePostRequest()`
- Organized into sections using editor fold comments:
  - Authorization Section
  - User Section (getCurrentUser, getUser, updateUser)
  - Group Section (getGroups, getGroup, createGroup, deleteGroup, etc.)
  - Friends Section (getFriends, getFriend, createFriend, etc.)
  - Expenses Section (getExpense, getExpenses, createExpense, etc.)
  - Comments Section (getComments, createComment, deleteComment)
  - Notification Section (getNotifications)
  - Currencies Section (getCurrencies, getCategories, parseSentence)

### `lib/src/util/helper/TokensHelper.dart`
- Simple data class for OAuth tokens
- Properties: `_token`, `_tokenSecret`
- Factory constructors: `fromMap()`, `fromJSON()`
- Serialization: `toString()`, `toJSON()`

### `example/example.dart`
- Demonstrates the OAuth flow
- Shows how to save/retrieve tokens
- Example API call usage

## Important Notes
- **No data models**: API responses are returned as raw JSON strings or status codes
- **No test directory**: No tests currently implemented
- **No analysis configuration**: No `analysis_options.yaml` file
- **Minimal structure**: Intentionally simple with only 4 Dart files
