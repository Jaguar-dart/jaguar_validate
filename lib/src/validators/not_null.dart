part of jaguar_validate.src.validators;

class IsNotNull implements FieldValidator<Object> {
  const IsNotNull();

  Future<PropertyValidationErrors> validate(String field, Object param) async {
    if (param == null) {
      return _mkPEr(field, '$field cannot be null!');
    }

    return _mkPErL(field, []);
  }
}
