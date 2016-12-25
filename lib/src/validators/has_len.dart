part of jaguar_validate.src.validators;

class HasLen implements FieldValidator {
  final int length;

  const HasLen(this.length);

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