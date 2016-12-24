part of jaguar_validate.src;

class ValidIf<FieldType> implements FieldValidator<FieldType> {
  final ValidatorFunc<FieldType> validator;

  ValidIf(this.validator);

  Future<List<ValidationError>> validate(String field, FieldType param) async {
    return validator(param);
  }
}

class IsNotNull implements FieldValidator<Object> {
  const IsNotNull();

  Future<List<ValidationError>> validate(String field, Object param) async {
    if(param == null) {
      return [new ValidationError('$field cannot be null!')];
    }

    return [];
  }
}

class IsEqual<FieldType> implements FieldValidator<FieldType> {
  final FieldType to;

  const IsEqual(this.to);

  Future<List<ValidationError>> validate(String field, FieldType param) async {
    if(param is! FieldType) {
      return [new ValidationError('$field must be of type $FieldType!')];
    }

    if(param != to) {
      return [new ValidationError('$field is not equal to $to!')];
    }

    return [];
  }
}

class IsNotEmpty implements FieldValidator {
  const IsNotEmpty();

  Future<List<ValidationError>> validate(String field, dynamic param) async {
    if(param is String || param is List || param is Map || param is Set) {
      if(param.isEmpty) {
        return _mkErL('$field must not be empty!');
      }
    } else {
      return _mkErL('$field must not be empty!');
    }

    return [];
  }
}

class HasLength implements FieldValidator {
  final int length;

  const HasLength(this.length);

  Future<List<ValidationError>> validate(String field, dynamic param) async {
    if(param is String || param is List || param is Map || param is Set) {
      if(param.length != length) {
        return _mkErL('$field must have length $length!');
      }
    } else {
      return _mkErL('$field must have length $length!');
    }

    return [];
  }
}

class HasLengthLessThan implements FieldValidator {
  final int length;

  const HasLengthLessThan(this.length);

  Future<List<ValidationError>> validate(String field, dynamic param) async {
    if(param is String || param is List || param is Map || param is Set) {
      if(param.length >= length) {
        return _mkErL('$field must have length less than $length!');
      }
    } else {
      return _mkErL('$field must have length less than $length!');
    }

    return [];
  }
}

class HasLengthGreaterThan implements FieldValidator {
  final int length;

  const HasLengthGreaterThan(this.length);

  Future<List<ValidationError>> validate(String field, dynamic param) async {
    if(param is String || param is List || param is Map || param is Set) {
      if(param.length <= length) {
        return _mkErL('$field must have length greater than $length!');
      }
    } else {
      return _mkErL('$field must have length greater than $length!');
    }

    return [];
  }
}

class HasLengthInRange implements FieldValidator {
  final num min;

  final num max;

  final bool whenNotNull;

  const HasLengthInRange(this.min, this.max, {this.whenNotNull: false});

  Future<List<ValidationError>> validate(String field, dynamic param) async {
    if(param is String || param is List || param is Map || param is Set) {
      if(param.length < min) {
        return _mkErL('$field must have length greater than $min!');
      }

      if(param.length > max) {
        return _mkErL('$field must have length less than $max!');
      }
    } else {
      if(param == null && whenNotNull) {
        //Throw no error if whenNotNull is true
      } else {
        return _mkErL('$field must be in range [$min, $max]!');
      }
    }

    return [];
  }
}

class IsGreaterThan implements FieldValidator {
  final num value;

  const IsGreaterThan(this.value);

  Future<List<ValidationError>> validate(String field, dynamic param) async {
    if(param is int || param is double || param is num) {
      if(param <= value) {
        return _mkErL('$field must be greater than $value!');
      }
    } else {
      return _mkErL('$field must be greater than $value!');
    }

    return [];
  }
}

class IsLessThan implements FieldValidator {
  final num value;

  const IsLessThan(this.value);

  Future<List<ValidationError>> validate(String field, dynamic param) async {
    if(param is int || param is double || param is num) {
      if(param >= value) {
        return _mkErL('$field must be less than $value!');
      }
    } else {
      return _mkErL('$field must be less than $value!');
    }

    return [];
  }
}

class IsInRange implements FieldValidator {
  final num min;

  final num max;

  final bool whenNotNull;

  const IsInRange(this.min, this.max, {this.whenNotNull: false});

  Future<List<ValidationError>> validate(String field, dynamic param) async {
    if(param is int || param is double || param is num) {
      if(param < min) {
        return _mkErL('$field must be greater than $min!');
      }
      if(param > max) {
        return _mkErL('$field must be less than $max!');
      }
    } else {
      if(param == null && whenNotNull) {
        //Throw no error if whenNotNull is true
      } else {
        return _mkErL('$field must be in range [$min, $max]!');
      }
    }

    return [];
  }
}


class IsEmail implements FieldValidator<String> {
  const IsEmail();

  Future<List<ValidationError>> validate(String field, String param) async {
    //TODO

    return [];
  }
}