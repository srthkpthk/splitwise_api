# Splitwise OpenAPI specification

`openapi.json` is a copy of the OpenAPI 3.0.1 document that Splitwise publishes
for its API v3.0 (source repository: <https://github.com/splitwise/api-docs>,
rendered at <https://dev.splitwise.com>). It is the property of Splitwise, Inc.
and is included here solely so that this package's test suite can verify the
client against the documented contract.

The file is excluded from the published pub.dev package (see `.pubignore`).

Tests that read it:

- `test/spec_coverage_test.dart` — every documented operation has a client method.
- `test/models_test.dart` — every model round-trips the documented schema.
