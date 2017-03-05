// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library jaguar_validate.src.core;

import 'dart:async';
import 'dart:convert';
import 'dart:collection';

part 'object_errors.dart';
part 'object_validator.dart';
part 'property_errors.dart';

/// Annotation to request generation of validator
class GenValidator {
  const GenValidator();
}

class ValidationError {
  final String msg;

  ValidationError(this.msg);

  String toString() => msg;
}

abstract class ValidationErrors {
  bool get hasErrors;

  List<PropertyValidationErrors> get properties;
}

class ValidationBug {
  final String msg;

  ValidationBug(this.msg);

  String toString() => msg;
}

abstract class FieldValidator<FieldType> {
  Future<ValidationErrors> validate(String field, FieldType param);
}

class ValidatableField<FieldType> {
  final String field;

  final FieldType value;

  final FieldValidator validator;

  ValidatableField(this.field, this.value, this.validator);
}

abstract class Validatable {
  /// Validates the model
  ///
  /// Must throw [ObjectValidationErrors] when validation fails
  Future<Null> validate();
}
