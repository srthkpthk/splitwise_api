# Task Completion Checklist

When completing a task in this codebase, follow these steps:

## Before Committing

### 1. Code Analysis
```bash
dart analyze
```
- Fix all errors and warnings
- Address any linter issues

### 2. Format Code (if modified)
```bash
dart format lib/ example/
```

### 3. Run Build Runner (if models/serialization changed)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Update Version (if applicable)
- Update version in `pubspec.yaml`
- Add entry to `CHANGELOG.md` with changes

### 5. Update Documentation
- Update `README.md` if public API changed
- Update `CLAUDE.md` if architecture changed
- Add/update code comments for new public methods

## Testing
**Note**: This project currently has no test suite. If tests are added in the future:
```bash
dart test
```

## Git Workflow
```bash
# Check status
git status

# Stage changes
git add .

# Commit with meaningful message
git commit -m "descriptive message"

# Push to remote
git push
```

## Publishing Checklist (for releases)
1. Ensure version is updated in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Run `dart pub publish --dry-run`
4. Fix any issues reported
5. Run `dart pub publish`

## Notes
- **No Tests**: Currently no testing infrastructure
- **No CI/CD**: No automated checks configured
- **Manual Verification**: Test changes manually using the example
