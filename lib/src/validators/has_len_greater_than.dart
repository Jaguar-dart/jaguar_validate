part of jaguar_validate.src.validators;

class HasLenGreaterThan implements FieldValidator {
  final int length;

  const HasLenGreaterThan(this.length);

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