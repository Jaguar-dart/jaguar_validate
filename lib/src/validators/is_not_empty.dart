part of jaguar_validate.src.validators;

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