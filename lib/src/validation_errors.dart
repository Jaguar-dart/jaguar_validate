import 'dart:convert';

import 'package:jaguar_validate/jaguar_validate.dart';

class ObjectErrors {
  final _errors = <String, dynamic>{};

  void addError(
      /* String | Iterable<String> */ key,
      /* Map<String, dynamic> | Iterable<String> */ errors) {
    if (errors is Iterable) {
      // Do nothing
    } else if (errors is Map<String, dynamic>) {
      // Do nothing
    } else if (errors is ObjectErrors) {
      errors = errors.asMap;
    } else if (errors == null) {
      return;
    } else {
      throw ArgumentError('${errors.runtimeType} is invalid error object');
    }

    Iterable<String> iterable;
    if (key is String) {
      iterable = key.split('.');
    } else if (key is Iterable) {
      iterable = key.cast<String>();
    } else {
      throw Exception('key must be String or Iterable');
    }

    if (iterable.isEmpty) {
      throw ArgumentError(
          'there should at least be one path segment in the key');
    }

    Iterator<String> iterator = iterable.take(iterable.length - 1).iterator;
    String lastKey = iterable.last;

    Map current = _errors;

    while (iterator.moveNext()) {
      if (current.containsKey(iterator.current)) {
        final tmp = current[iterator.current];
        if (tmp is! Map) {
          throw Exception('unexpected structure');
        }
        current = tmp;
      } else {
        final map = <String, dynamic>{};
        current[iterator.current] = map;
        current = map;
      }
    }

    var destination = current[lastKey];
    if (destination == null) {
      if (errors is Iterable) {
        destination = current[lastKey] = [];
      } else {
        destination = current[lastKey] = <String, dynamic>{};
      }
    }

    _mergeErrors(destination, errors);
  }

  dynamic operator [](/* String | Iterable<String> */ key) {
    Iterable<String> iterable;
    if (key is String) {
      iterable = key.split('.');
    } else if (key is Iterable) {
      iterable = key.cast<String>();
    } else {
      throw Exception('key must be String or Iterable');
    }

    if (iterable.isEmpty) {
      throw ArgumentError(
          'there should at least be one path segment in the key');
    }

    Iterator<String> iterator = iterable.take(iterable.length - 1).iterator;
    String lastKey = iterable.last;

    Map current = _errors;

    while (iterator.moveNext()) {
      if (current.containsKey(iterator.current)) {
        final tmp = current[iterator.current];
        if (current is! Map) {
          throw Exception('unexpected structure');
        }
        current = tmp;
      } else {
        return null;
      }
    }

    return cloneErrorValue(current[lastKey]);
  }

  void operator []=(
      /* String | Iterable<String> */ key,
      /* Map<String, dynamic> | Iterable<String> */ errors) {
    if (errors is Iterable) {
      // Do nothing
    } else if (errors is Map<String, dynamic>) {
      // Do nothing
    } else if (errors is ObjectErrors) {
      errors = errors.asMap;
    } else if (errors == null) {
      // TODO cleanup tree
      return;
    } else {
      throw ArgumentError('${errors.runtimeType} is invalid error object');
    }

    Iterable<String> iterable;
    if (key is String) {
      iterable = key.split('.');
    } else if (key is Iterable) {
      iterable = key.cast<String>();
    } else {
      throw Exception('key must be String or Iterable');
    }

    if (iterable.isEmpty) {
      throw ArgumentError(
          'there should atleast be one path segment in the key');
    }

    Iterator<String> iterator = iterable.take(iterable.length - 1).iterator;
    String lastKey = iterable.last;

    Map current = _errors;

    while (iterator.moveNext()) {
      if (current.containsKey(iterator.current)) {
        final tmp = current[iterator.current];
        if (current is! Map) {
          throw Exception('unexpected structure');
        }
        current = tmp;
      } else {
        final map = <String, dynamic>{};
        current[iterator.current] = map;
        current = map;
      }
    }

    current[lastKey] = errors;
  }

  Map<String, dynamic> get asMap => cloneErrorValue(_errors);

  String toJson() => json.encode(asMap);

  static dynamic _mergeErrors(destination, source) {
    source = cloneErrorValue(source);
    if (source is Iterable) {
      if (destination is List) {
        destination.addAll(source);
      } else {
        throw Exception('unexpected structure');
      }
    } else if (source is Map) {
      if (destination is Map) {
        for (final key in source.keys) {
          if (!destination.containsKey(key)) {
            destination[key] = source[key];
          }
        }
      } else {
        throw Exception('unexpected structure');
      }
    }
  }

  static cloneErrorValue(/* Map<String, dynamic> | Iterable<String> */ errors) {
    if (errors is Iterable) {
      return errors
          .map((e) => e is Map
              ? ValidationError.fromMap(e)
              : (e is ValidationError ? e.clone() : e))
          .toList();
    } else if (errors is Map) {
      final inputMap = errors.cast<String, dynamic>();

      final ret = <String, dynamic>{};

      for (final key in inputMap.keys) {
        ret[key] = cloneErrorValue(inputMap[key]);
      }

      return ret;
    } else if (errors == null) {
      throw Exception('errors cannot be null');
    } else {
      throw UnsupportedError(
          '${errors.runtimeType} not supported. must be Map or List');
    }
  }
}

class ValidationError {
  int code;

  Map<String, dynamic> params;

  String message;

  ValidationError({this.code, this.params, this.message});

  factory ValidationError.fromMap(Map error) => ValidationError(
      code: error['code'],
      params: (error['params'] as Map)?.cast<String, dynamic>(),
      message: error['message']);

  ValidationError clone() => ValidationError(
      code: code,
      params: params != null ? Map.from(params) : null,
      message: message);

  Map<String, dynamic> asMap() {
    return {
      'code': code,
      'params': params,
      'message': message,
    };
  }

  String toJson() => json.encode(asMap());

  String toString() =>
      'ValidationError(code: $code, params: $params, message: $message)';
}
