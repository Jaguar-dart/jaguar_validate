part of jaguar_validate.src.validators;

class HasLenLessThan implements FieldValidator {
  final int length;

  const HasLenLessThan(this.length);

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
