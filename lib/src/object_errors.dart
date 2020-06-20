import 'dart:convert';

class ObjectErrors {
  final _errors = <String, dynamic>{};

  bool get hasErrors => _errors.isNotEmpty;

  void addError(
      /* String | Iterable<String> */ key,
      /* Map<String, dynamic> | Iterable<String> */ errors) {
    if (errors is Iterable) {
      // Do nothing
    } else if (errors is Map<String, dynamic>) {
      // Do nothing
    } else if (errors is ObjectErrors) {
      errors = errors.asMap;
      if (errors == null) {
        return;
      }
    } else if (errors == null) {
      return;
    } else {
      throw ArgumentError('${errors.runtimeType} is invalid error object');
    }

    Iterable<String> iterable = splitKey(key);

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
    Iterable<String> iterable = splitKey(key);

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
      // Do nothing
    } else {
      throw ArgumentError('${errors.runtimeType} is invalid error object');
    }

    final iterable = splitKey(key);

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

    if (errors != null) {
      current[lastKey] = errors;
    } else {
      current.remove(lastKey);
      cleanupErrors();
    }
  }

  void clear() {
    _errors.clear();
  }

  void _cleanupMap(Map map) {
    if (map == null) return;

    final remove = <String>[];

    for (final key in map.keys) {
      var e = map[key];
      if (e == null) {
        remove.add(key);
      } else if (e is Iterable) {
        if (e.isEmpty) {
          remove.add(key);
        }
      } else if (e is Map) {
        _cleanupMap(e);
        if (e.isEmpty) {
          remove.add(key);
        }
      }
    }

    for (final key in remove) {
      map.remove(key);
    }
  }

  void cleanupErrors() {
    _cleanupMap(_errors);
  }

  Map<String, dynamic> get asMap {
    if (!hasErrors) return null;

    return cloneErrorValue(_errors);
  }

  Map<String, dynamic> toJson() => asMap;

  // TODO implement flat representation

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

  static dynamic cloneErrorValue(
      /* Map<String, dynamic> | Iterable<String> */ errors) {
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

  static Iterable<String> splitKey(/* String | Iterable<String> */ key) {
    Iterable<String> iterable;
    if (key is String) {
      iterable = key.split('.');
    } else if (key is Iterable) {
      iterable = key.cast<String>().expand((element) => element.split(('.')));
    } else {
      throw Exception('key must be String or Iterable');
    }

    if (iterable.isEmpty) {
      throw ArgumentError(
          'there should atleast be one path segment in the key');
    }

    if (iterable.any((element) => element.isEmpty)) {
      throw ArgumentError('a key element cannot be empty');
    }

    return iterable;
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

  Map<String, dynamic> toJson() => asMap();

  @override
  String toString() =>
      'ValidationError(code: $code, params: $params, message: $message)';
}
