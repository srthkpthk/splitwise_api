# Suggested Commands

## Package Management
```bash
# Install dependencies
dart pub get

# Upgrade dependencies
dart pub upgrade

# Check for outdated packages
dart pub outdated
```

## Code Generation
```bash
# Run code generation once (for JSON serialization)
dart run build_runner build

# Run code generation in watch mode (continuous)
dart run build_runner watch

# Clean generated files before regenerating
dart run build_runner build --delete-conflicting-outputs
```

## Analysis and Linting
```bash
# Analyze code for issues
dart analyze

# Fix auto-fixable issues
dart fix --apply
```

## Publishing (Maintainers Only)
```bash
# Dry run of publish
dart pub publish --dry-run

# Publish to pub.dev
dart pub publish
```

## Git Commands (Darwin/macOS)
Standard git commands work on macOS:
```bash
git status
git add .
git commit -m "message"
git push
```

## File Operations (Darwin/macOS)
```bash
# List files
ls -la

# Find files
find . -name "*.dart"

# Search in files
grep -r "pattern" lib/

# Navigate
cd path/to/directory
```

## Notes
- **No Test Suite**: This project currently has no tests
- **No Linting Configuration**: No `analysis_options.yaml` file present
- **No Formatting Script**: Use standard `dart format` if needed
