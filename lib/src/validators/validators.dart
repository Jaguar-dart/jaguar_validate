library jaguar_validate.src.validators;

import 'package:jaguar_validate/jaguar_validate.dart';

export 'common.dart';
export 'string.dart';

typedef Validator<T> = List<String> Function(T value);

List<String> validateField<T>(T value, List<Validator<T>> validators) {
  final ret = <String>[];

  for (final v in validators) {
    final e = v(value);
    if (e == null || e.isEmpty) continue;

    ret.addAll(e);
  }

  if (ret.isEmpty) return null;

  return ret;
}

abstract class Validatable {
  ValidationErrors validate();
}