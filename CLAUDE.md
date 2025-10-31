# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Dart package that provides a wrapper for the Splitwise API (v3.0). It's published on pub.dev and uses OAuth 1.0 for authentication. The package is null-safe (SDK >=2.12.0 <3.0.0) and uses the `oauth1` package for authentication.

## Architecture

### Core Components

**SplitWiseService** (`lib/src/util/auth/splitwise_main.dart`): The main service class that handles all API interactions. It manages:
- OAuth 1.0 authentication flow using HMAC-SHA1 signature
- HTTP client initialization and lifecycle
- All API endpoint methods (users, groups, friends, expenses, comments, notifications, currencies)

**TokensHelper** (`lib/src/util/helper/TokensHelper.dart`): A simple data class for OAuth token management (token and tokenSecret). Provides serialization/deserialization methods for persistence.

**Package Entry Point** (`lib/splitwise_api.dart`): Exports the core classes using editor fold comments for organization.

### Authentication Flow

The authentication uses a 3-step OAuth 1.0 flow:
1. Call `validateClient()` with no parameters to get authorization URL
2. User authorizes and receives verifier code
3. Call `validateClient(verifier: code)` to exchange for tokens (returns TokensHelper)
4. For subsequent sessions: call `validateClient(tokens: savedTokens)` to restore session

The `validateClient()` method has three distinct behaviors based on input parameters, serving as the sole authentication method.

### API Request Pattern

All API methods follow a consistent pattern:
- Internal helper methods: `_makeGetRequest()` and `_makePostRequest()`
- Base URL: `https://secure.splitwise.com/api/v3.0/`
- Both methods check for initialized `_client` before making requests
- Return response body on success (200) or status code on failure
- Methods are organized into sections using editor fold comments: User, Group, Friends, Expenses, Comments, Notifications, Currencies

## Development Commands

### Build and Code Generation
```bash
# Generate code (for JSON serialization if needed)
dart run build_runner build

# Watch mode for continuous generation
dart run build_runner watch
```

### Testing
No test suite is currently present in the repository.

### Package Management
```bash
# Get dependencies
dart pub get

# Publish (requires proper credentials)
dart pub publish
```

## Key Implementation Details

- **No Data Models**: The package deliberately does not include data model classes. API responses are returned as raw JSON strings or status codes. Users are expected to parse responses themselves.
- **OAuth 1.0 Platform Configuration**: Uses hardcoded Splitwise OAuth endpoints with HMAC-SHA1 signature method.
- **Error Handling**: Throws exceptions when `_client` is not initialized. Some methods return boolean (success) or errors object.
- **Editor Fold Comments**: Code is organized using `<editor-fold desc="...">` comments for IDE folding.
- **Token Persistence**: Not handled by the package - developers must implement their own storage (SharedPreferences, secure storage, etc.).

## Common Patterns

When adding new API endpoints:
1. Add method in appropriate section (User/Group/Friends/Expenses/etc.)
2. Use `_makeGetRequest()` or `_makePostRequest()` with path and optional query parameters
3. Follow naming convention: `getResource()`, `createResource()`, `updateResource()`, `deleteResource()`
4. For delete operations that return success flags, check `t.success` and return `true` or `t.errors`

## Version Information

Current version: 2.0.3
- Uses OAuth 1.0 (not OAuth 2.0)
- All methods from Splitwise DEV API website are included
- Based on null-safety
