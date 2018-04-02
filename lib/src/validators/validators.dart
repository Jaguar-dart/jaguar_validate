library jaguar_validate.src.validators;

import 'dart:async';

import 'common/common.dart';
import 'num/num.dart';
import 'string/string.dart';

export 'common/common.dart';
export 'num/num.dart';
export 'string/string.dart';

RegExp _creditCard = new RegExp(
    r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$');

RegExp _int = new RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
RegExp _float =
    new RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
RegExp _hexadecimal = new RegExp(r'^[0-9a-fA-F]+$');
RegExp _hexcolor = new RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

abstract class FieldValidator<FieldType> {
  FutureOr<dynamic> validate(FieldType param);
}

class ObjectErrors {
  final Map<String, List<dynamic>> _errors = {};

  ObjectErrors();

  List<String> get fields => _errors.keys;

  bool get hasErrors => _errors.length != 0;

  /// Adds error [error] to the field [field]
  void add(String field, dynamic error) {
    if (error == null) return;

    if (!_errors.containsKey(field)) {
      _errors[field] = [];
    }
    if (error is Iterable) {
      _errors[field].addAll(error);
    } else {
      _errors[field].add(error);
    }
  }

  void addAll(Map<String, dynamic> errors) {
    for (String field in errors.keys) {
      add(field, errors[field]);
    }
  }

  Map<String, dynamic> toJson() => _errors; // TODO clone
}

abstract class Validatable {
  /// Validates the model
  FutureOr<dynamic> validate();
}

typedef dynamic ValidatorFunc<FieldType>(FieldType param);

class ValidIf<FieldType> implements FieldValidator<FieldType> {
  final ValidatorFunc<FieldType> validator;

  ValidIf(this.validator);

  dynamic validate(FieldType param) {
    return validator(param);
  }
}

abstract class Validate {
  static StringValidator get string => new StringValidator();

  static NumValidator get num => new NumValidator();

  static IntValidator get int => new IntValidator();

  static DoubleValidator get double => new DoubleValidator();
}