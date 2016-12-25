part of jaguar_validate.src.core;

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
    } else if (errorsList is! PropertyValidationErrors) {
      throw new ValidationBug('Not a property error container!');
    }

    (errorsList as PropertyValidationErrors).add(error);

    return this;
  }

  ObjectValidationErrors mergePErr(PropertyValidationErrors err) {
    err._errors.forEach((ValidationError v) => addPErr(err.field, v));

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
      err.mergeOErr(error);
    } else {
      throw new ValidationBug('Not a Object error container!');
    }

    return this;
  }

  ObjectValidationErrors mergeOErr(ObjectValidationErrors error) {
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

    for (String field in _errors.keys) {
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
