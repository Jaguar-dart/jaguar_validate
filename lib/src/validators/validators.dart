library jaguar_validate.src.validators;

import 'package:jaguar_validate/jaguar_validate.dart';

export 'common.dart';
export 'string.dart';

typedef ValidationRule<T> = List Function(T value);

List validateValue<T>(T value, List<ValidationRule<T>> validators) {
  final ret = [];

  for (final v in validators) {
    final e = v(value);
    if (e == null || e.isEmpty) continue;

    ret.addAll(e);
  }

  if (ret.isEmpty) return null;

  return ret;
}

abstract class Validatable {
  ObjectErrors validate();
}