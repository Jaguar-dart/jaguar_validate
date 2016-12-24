// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library jaguar_validate.src;

import 'dart:async';
import 'dart:convert';

part 'annotations.dart';

class ValidationError {
  final String msg;

  ValidationError(this.msg);

  String toString() => msg;
}

ValidationError _mkEr(String msg) => new ValidationError(msg);

List<ValidationError> _mkErL(String msg) => [new ValidationError(msg)];

class ValidationErrors {
  final Map<String, List<ValidationError>> _errors = {};

  Map<String, List<ValidationError>> get errors => _errors;

  void addError(String field, ValidationError error) {
    List<ValidationError> errorsList = _errors[field];

    if(errorsList == null) {
      errorsList = [];
      _errors[field] = errorsList;
    }

    errorsList.add(error);
  }

  bool fieldHasError(String field) => _errors.containsKey(field);

  Map toMap() {
    final Map<String, List<String>> map = {};

    for(String field in map.keys) {
      List<String> errors = [];

      for(ValidationError v in _errors[field]) {
        errors.add(v.msg);
      }

      map[field] = errors;
    }

    return map;
  }

  String toString() => JSON.encode(toMap());
}

typedef List<ValidationError> ValidatorFunc<FieldType>(FieldType param);

abstract class FieldValidator<FieldType> {
  Future<List<ValidationError>> validate(String field, FieldType param);
}

