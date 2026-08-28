import 'dart:convert';
import 'dart:io';

/// The committed copy of Splitwise's OpenAPI document.
final Map<String, dynamic> spec =
    jsonDecode(File('spec/openapi.json').readAsStringSync())
        as Map<String, dynamic>;

/// `components.schemas` of the spec.
Map<String, dynamic> get specSchemas =>
    (spec['components'] as Map<String, dynamic>)['schemas']
        as Map<String, dynamic>;

/// `paths` of the spec.
Map<String, dynamic> get specPaths => spec['paths'] as Map<String, dynamic>;

/// Resolves a local reference such as `#/components/schemas/user`.
Map<String, dynamic> resolveRef(String ref) {
  Object? node = spec;
  for (final segment in ref.split('/').skip(1)) {
    node = (node as Map<String, dynamic>)[segment];
  }
  return node as Map<String, dynamic>;
}

/// Returns [schema] with `$ref` resolved and `allOf` flattened.
///
/// Properties of later `allOf` members are merged key-by-key into earlier
/// ones, so a member that only overrides `example` keeps the original type.
Map<String, dynamic> mergeSchema(Map<String, dynamic> schema) {
  final ref = schema[r'$ref'];
  if (ref is String) {
    return mergeSchema(resolveRef(ref));
  }
  final allOf = schema['allOf'];
  if (allOf is! List) {
    return schema;
  }
  final merged = <String, dynamic>{};
  final properties = <String, dynamic>{};
  for (final part in allOf.cast<Map<String, dynamic>>()) {
    final member = mergeSchema(part);
    for (final entry in member.entries) {
      switch (entry.key) {
        case 'properties':
          for (final prop in (entry.value as Map<String, dynamic>).entries) {
            final existing = properties[prop.key];
            properties[prop.key] = <String, dynamic>{
              if (existing is Map<String, dynamic>) ...existing,
              ...prop.value as Map<String, dynamic>,
            };
          }
        case 'required':
          merged['required'] = [
            ...?(merged['required'] as List?),
            ...entry.value as List,
          ];
        default:
          merged[entry.key] = entry.value;
      }
    }
  }
  for (final entry in schema.entries) {
    if (entry.key != 'allOf') {
      merged[entry.key] = entry.value;
    }
  }
  if (properties.isNotEmpty) {
    merged['properties'] = properties;
  }
  merged.putIfAbsent('type', () => 'object');
  return merged;
}

/// Navigates [schema] by property names (or `items` for array elements) and
/// returns the merged schema found there.
Map<String, dynamic> schemaAt(Map<String, dynamic> schema, List<String> path) {
  var current = mergeSchema(schema);
  for (final segment in path) {
    final next = segment == 'items'
        ? current['items']
        : (current['properties'] as Map<String, dynamic>)[segment];
    current = mergeSchema(next as Map<String, dynamic>);
  }
  return current;
}

/// The merged component schema [name], optionally narrowed by [path].
Map<String, dynamic> componentSchema(
  String name, [
  List<String> path = const [],
]) => schemaAt(specSchemas[name] as Map<String, dynamic>, path);

/// The merged `200` response schema of `method path`, optionally narrowed.
Map<String, dynamic> responseSchema(
  String path,
  String method, [
  List<String> sub = const [],
]) {
  final operation =
      (specPaths[path] as Map<String, dynamic>)[method] as Map<String, dynamic>;
  final responses = operation['responses'] as Map<String, dynamic>;
  final ok = responses['200'] as Map<String, dynamic>;
  final content = ok['content'] as Map<String, dynamic>;
  final json = content['application/json'] as Map<String, dynamic>;
  return schemaAt(json['schema'] as Map<String, dynamic>, sub);
}

/// The merged JSON request-body schema of `POST path`.
Map<String, dynamic> requestSchema(String path) {
  final operation =
      (specPaths[path] as Map<String, dynamic>)['post'] as Map<String, dynamic>;
  final body = operation['requestBody'] as Map<String, dynamic>;
  final content = body['content'] as Map<String, dynamic>;
  final json = content['application/json'] as Map<String, dynamic>;
  return mergeSchema(json['schema'] as Map<String, dynamic>);
}

/// The `example` request body documented for `POST path`, if any.
Map<String, dynamic>? requestExample(String path) {
  final operation =
      (specPaths[path] as Map<String, dynamic>)['post'] as Map<String, dynamic>;
  final body = operation['requestBody'] as Map<String, dynamic>;
  final content = body['content'] as Map<String, dynamic>;
  final json = content['application/json'] as Map<String, dynamic>;
  return json['example'] as Map<String, dynamic>?;
}

/// Names of the properties documented on [schema].
Set<String> propertyKeys(Map<String, dynamic> schema) {
  final properties = mergeSchema(schema)['properties'];
  return properties is Map ? properties.keys.cast<String>().toSet() : {};
}

/// Builds an example JSON value for [raw], preferring the spec's own
/// `example` values and falling back to type-appropriate placeholders.
Object? exampleOf(Map<String, dynamic> raw) {
  final schema = mergeSchema(raw);
  if (schema.containsKey('example')) {
    return schema['example'];
  }
  final oneOf = schema['oneOf'];
  if (oneOf is List) {
    return exampleOf(oneOf.first as Map<String, dynamic>);
  }
  final type = schema['type'];
  final properties = schema['properties'];
  if (type == 'object' || properties is Map) {
    final out = <String, dynamic>{};
    if (properties is Map<String, dynamic>) {
      for (final entry in properties.entries) {
        out[entry.key] = exampleOf(entry.value as Map<String, dynamic>);
      }
    }
    final additional = schema['additionalProperties'];
    if (additional is Map<String, dynamic>) {
      out['extra'] = exampleOf(additional);
    }
    return out;
  }
  if (type == 'array') {
    return [exampleOf(schema['items'] as Map<String, dynamic>)];
  }
  final enumValues = schema['enum'];
  if (enumValues is List) {
    return enumValues.firstWhere((v) => v != null, orElse: () => null);
  }
  return switch (type) {
    'integer' => 1,
    'number' => 1.5,
    'boolean' => true,
    'string' =>
      schema['format'] == 'date-time' ? '2020-07-28T20:46:00Z' : 'string',
    _ => null,
  };
}

/// An example of a successful `200` body for `method path`, with any
/// `errors` member removed and `success` forced to `true`.
Map<String, dynamic> okResponseExample(String path, String method) {
  final body = exampleOf(responseSchema(path, method)) as Map<String, dynamic>;
  body.remove('errors');
  if (body.containsKey('success')) {
    body['success'] = true;
  }
  return body;
}

/// Every `(method, path)` operation documented in the spec, e.g.
/// `GET /get_user/{id}`.
Set<String> specOperations() => {
  for (final path in specPaths.entries)
    for (final method in (path.value as Map<String, dynamic>).keys)
      if (const {'get', 'post', 'put', 'delete', 'patch'}.contains(method))
        '${method.toUpperCase()} ${path.key}',
};
