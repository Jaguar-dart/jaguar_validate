part of jaguar_validate.src.validators;

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
