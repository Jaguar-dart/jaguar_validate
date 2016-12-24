part of jaguar_validate.src;

abstract class Validatable {
  /// Validates the model
  ///
  /// Must throw [ObjectValidationErrors] when validation fails
  Future<Null> validate();
}

class ValidateValidatable implements FieldValidator<Validatable> {
  const ValidateValidatable();

  Future<ValidationErrors> validate(String field, Validatable param) async {
    ObjectValidationErrors errors = new ObjectValidationErrors(field);

    try {
      await param.validate();
    } on ObjectValidationErrors catch (e) {
      errors = e;
      errors.field = field;
    }

    return errors;
  }
}

class ValidIf<FieldType> implements FieldValidator<FieldType> {
  final ValidatorFunc<FieldType> validator;

  ValidIf(this.validator);

  Future<PropertyValidationErrors> validate(
      String field, FieldType param) async {
    return validator(param);
  }
}

class IsNotNull implements FieldValidator<Object> {
  const IsNotNull();

  Future<PropertyValidationErrors> validate(String field, Object param) async {
    if (param == null) {
      return _mkPEr(field, '$field cannot be null!');
    }

    return _mkPErL(field, []);
  }
}

class IsEqual<FieldType> implements FieldValidator<FieldType> {
  final FieldType to;

  const IsEqual(this.to);

  Future<PropertyValidationErrors> validate(
      String field, FieldType param) async {
    if (param is! FieldType) {
      return _mkPEr(field, '$field must be of type $FieldType!');
    }

    if (param != to) {
      return _mkPEr(field, '$field is not equal to $to!');
    }

    return _mkPErL(field, []);
  }
}

class IsNotEmpty implements FieldValidator {
  const IsNotEmpty();

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is String || param is List || param is Map || param is Set) {
      if (param.isEmpty) {
        return _mkPEr(field, '$field must not be empty!');
      }
    } else {
      return _mkPEr(field, '$field must not be empty!');
    }

    return _mkPErL(field, []);
  }
}

class HasLength implements FieldValidator {
  final int length;

  const HasLength(this.length);

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is String || param is List || param is Map || param is Set) {
      if (param.length != length) {
        return _mkPEr(field, '$field must have length $length!');
      }
    } else {
      return _mkPEr(field, '$field must have length $length!');
    }

    return _mkPErL(field, []);
  }
}

class HasLengthLessThan implements FieldValidator {
  final int length;

  const HasLengthLessThan(this.length);

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is String || param is List || param is Map || param is Set) {
      if (param.length >= length) {
        return _mkPEr(field, '$field must have length less than $length!');
      }
    } else {
      return _mkPEr(field, '$field must have length less than $length!');
    }

    return _mkPErL(field, []);
  }
}

class HasLengthGreaterThan implements FieldValidator {
  final int length;

  const HasLengthGreaterThan(this.length);

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is String || param is List || param is Map || param is Set) {
      if (param.length <= length) {
        return _mkPEr(field, '$field must have length greater than $length!');
      }
    } else {
      return _mkPEr(field, '$field must have length greater than $length!');
    }

    return _mkPErL(field, []);
  }
}

class HasLengthInRange implements FieldValidator {
  final num min;

  final num max;

  final bool whenNotNull;

  const HasLengthInRange(this.min, this.max, {this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is String || param is List || param is Map || param is Set) {
      if (param.length < min) {
        return _mkPEr(field, '$field must have length greater than $min!');
      }

      if (param.length > max) {
        return _mkPEr(field, '$field must have length less than $max!');
      }
    } else {
      if (param == null && whenNotNull) {
        //Throw no error if whenNotNull is true
      } else {
        return _mkPEr(field, '$field must be in range [$min, $max]!');
      }
    }

    return _mkPErL(field, []);
  }
}

class IsGreaterThan implements FieldValidator {
  final num value;

  const IsGreaterThan(this.value);

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is int || param is double || param is num) {
      if (param <= value) {
        return _mkPEr(field, '$field must be greater than $value!');
      }
    } else {
      return _mkPEr(field, '$field must be greater than $value!');
    }

    return _mkPErL(field, []);
  }
}

class IsLessThan implements FieldValidator {
  final num value;

  const IsLessThan(this.value);

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is int || param is double || param is num) {
      if (param >= value) {
        return _mkPEr(field, '$field must be less than $value!');
      }
    } else {
      return _mkPEr(field, '$field must be less than $value!');
    }

    return _mkPErL(field, []);
  }
}

class IsInRange implements FieldValidator {
  final num min;

  final num max;

  final bool whenNotNull;

  const IsInRange(this.min, this.max, {this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is int || param is double || param is num) {
      if (param < min) {
        return _mkPEr(field, '$field must be greater than $min!');
      }
      if (param > max) {
        return _mkPEr(field, '$field must be less than $max!');
      }
    } else {
      if (param == null && whenNotNull) {
        //Throw no error if whenNotNull is true
      } else {
        return _mkPEr(field, '$field must be in range [$min, $max]!');
      }
    }

    return _mkPErL(field, []);
  }
}

class IsEmail implements FieldValidator<String> {
  const IsEmail();

  Future<PropertyValidationErrors> validate(String field, String param) async {
    //TODO

    return _mkPErL(field, []);
  }
}
