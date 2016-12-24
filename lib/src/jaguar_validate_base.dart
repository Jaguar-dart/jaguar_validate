// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library jaguar_validate.src;

import 'dart:async';
import 'dart:convert';

part 'annotations.dart';

class GenValidator {
  const GenValidator();
}

class ValidationError {
  final String msg;

  ValidationError(this.msg);

  String toString() => msg;
}

class ValidationBug {
  final String msg;

  ValidationBug(this.msg);

  String toString() => msg;
}

PropertyValidationErrors _mkPEr(String field, String msg) =>
    new PropertyValidationErrors(field)..add(new ValidationError(msg));

PropertyValidationErrors _mkPErL(String field, List<String> msges) {
  PropertyValidationErrors ret = new PropertyValidationErrors(field);
  msges.forEach((String msg) => ret.add(new ValidationError(msg)));
  return ret;
}

abstract class ValidationErrors {}

class PropertyValidationErrors implements ValidationErrors {
  final String field;

  final List<ValidationError> _errors = [];

  PropertyValidationErrors(this.field);

  List<ValidationError> get errors => _errors.toList();

  bool get hasErrors => _errors.length != 0;

  void add(ValidationError error) {
    _errors.add(error);
  }

  List<String> toList() =>
      _errors.map((ValidationError v) => v.toString()).toList();
}

class ObjectValidationErrors implements ValidationErrors {
  String _field;

  final Map<String, ValidationErrors> _errors = {};

  ObjectValidationErrors(String field) {
    this.field = field;
  }

  Map<String, ValidationErrors> get errors => _errors;

  set field(String field) => _field = field;

  String get field => _field;

  bool get hasErrors => _errors.length != 0;

  ObjectValidationErrors addPErr(String field, ValidationError error) {
    ValidationErrors errorsList = _errors[field];

    if (errorsList == null) {
      errorsList = new PropertyValidationErrors(field);
      _errors[field] = errorsList;
    } else if (errorsList is PropertyValidationErrors) {
      errorsList.add(error);
    } else {
      throw new ValidationBug('Not a property error container!');
    }

    return this;
  }

  ObjectValidationErrors mergePErr(PropertyValidationErrors err) {
    err._errors.forEach((ValidationError v) => addPErr(field, v));

    return this;
  }

  ObjectValidationErrors addOErr(ObjectValidationErrors error) {
    if (!error.hasErrors) {
      return this;
    }

    ValidationErrors err = _errors[error.field];

    if (err == null) {
      _errors[error.field] = error;
    } else if (err is ObjectValidationErrors) {
      err.mergeObjectError(error);
    } else {
      throw new ValidationBug('Not a Object error container!');
    }

    return this;
  }

  ObjectValidationErrors mergeObjectError(ObjectValidationErrors error) {
    for (String field in error._errors.keys) {
      ValidationErrors err = error._errors[field];

      if (err is PropertyValidationErrors) {
        mergePErr(err);
      } else if (err is ObjectValidationErrors) {
        addOErr(err);
      } else {
        throw new ValidationBug('Unknown error container!');
      }
    }

    return this;
  }

  bool fieldHasError(String field) => _errors.containsKey(field);

  Map toMap() {
    final Map<String, dynamic> map = {};

    for (String field in map.keys) {
      ValidationErrors v = _errors[field];

      if (v is PropertyValidationErrors) {
        map[field] = v.toList();
      } else if (v is ObjectValidationErrors) {
        map[field] = v.toMap();
      } else {
        throw new ValidationBug('Unknown error container!');
      }
    }

    return map;
  }

  String toString() => JSON.encode(toMap());
}

typedef Future<PropertyValidationErrors> ValidatorFunc<FieldType>(
    FieldType param);

abstract class FieldValidator<FieldType> {
  Future<PropertyValidationErrors> validate(String field, FieldType param);
}
