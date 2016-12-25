part of jaguar_validate.src.validators;

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