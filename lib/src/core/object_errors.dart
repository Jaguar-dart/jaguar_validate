part of jaguar_validate.src.core;

class ObjectValidationErrors implements ValidationErrors {
  String _field;

  final Map<String, PropertyValidationErrors> _errors = {};

  ObjectValidationErrors(String field) {
    this.field = field;
  }

  List<PropertyValidationErrors> get properties => _errors.values;

  set field(String field) => _field = field;

  String get field => _field;

  bool get hasErrors => _errors.length != 0;

  /// Adds error [error] to the field [field]
  ObjectValidationErrors addError(String field, ValidationError error) {
    PropertyValidationErrors errorsList = _errors[field];

    if (errorsList == null) {
      errorsList = new PropertyValidationErrors(field);
      _errors[field] = errorsList;
    }

    errorsList.add(error);

    return this;
  }

  ObjectValidationErrors addPropertyError(PropertyValidationErrors err) {
    PropertyValidationErrors errorsList = _errors[err.field];

    if (errorsList == null) {
      _errors[err.field] = err;
    } else {
      errorsList.addAll(err.errors);
    }

    return this;
  }

  ObjectValidationErrors includeObjectErrors(ObjectValidationErrors error) {
    if (error.field is String && error.field.length != 0) {
      for (final String field in error._errors.keys) {
        final PropertyValidationErrors oldErr = error._errors[field];
        final PropertyValidationErrors newErr =
            new PropertyValidationErrors(error.field + '.' + field);
        newErr.addAll(oldErr.errors);
        addPropertyError(newErr);
      }
    } else {
      for (final field in error._errors.keys) {
        PropertyValidationErrors err = error._errors[field];
        addPropertyError(err);
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
