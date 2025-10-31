# Code Style and Conventions

## Naming Conventions
- **Classes**: PascalCase (e.g., `SplitWiseService`, `TokensHelper`)
- **Methods**: camelCase (e.g., `getCurrentUser()`, `validateClient()`)
- **Private members**: Prefix with underscore (e.g., `_client`, `_makeGetRequest()`)
- **Parameters**: camelCase with descriptive names

## Code Organization
- **Editor Fold Comments**: Code is organized using `<editor-fold desc="...">` and `</editor-fold>` comments for IDE folding
- Sections include:
  - Method Utils
  - Authorization Section
  - User Section
  - Group Section
  - Friends Section
  - Expenses Section
  - Comments Section
  - Notification Section
  - Currencies Section

## API Method Patterns
All API methods follow consistent patterns:

### GET Requests
```dart
methodName({Map<String, String>? options}) async =>
    await _makeGetRequest('endpoint_path', options: options);
```

### POST Requests
```dart
methodName(Map<String, String> options) async =>
    await _makePostRequest('endpoint_path', options: options);
```

### Delete Operations
```dart
deleteResource(int id) async {
  var t = await _makePostRequest('delete_resource/$id');
  return t.success! ? true : t.errors;
}
```

## Null Safety
- Project is fully null-safe (SDK >=2.12.0)
- Use nullable types (`?`) appropriately
- Use null-aware operators (`?.`, `??`, `!`) where needed

## Error Handling
- Throw exceptions for client not initialized: `throw Exception('Please use validateClient First')`
- Return status codes or error objects on API failures
- Print debug information using `print()` statements

## Documentation
- Use `///` for public API documentation comments
- Include brief descriptions of method purpose and parameters
- No extensive documentation required for internal methods

## Design Patterns
- **Factory Constructors**: Used in TokensHelper for deserialization (`TokensHelper.fromMap`, `TokensHelper.fromJSON`)
- **Named Constructors**: Used for initialization (`SplitWiseService.initialize()`)
- **Private Helper Methods**: Internal HTTP methods prefixed with underscore
- **Async/Await**: All API methods are asynchronous
