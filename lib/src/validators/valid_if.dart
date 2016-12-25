part of jaguar_validate.src.validators;

typedef Future<PropertyValidationErrors> ValidatorFunc<FieldType>(
    FieldType param);

class ValidIf<FieldType> implements FieldValidator<FieldType> {
  final ValidatorFunc<FieldType> validator;

  ValidIf(this.validator);

  Future<PropertyValidationErrors> validate(
      String field, FieldType param) async {
    return validator(param);
  }
}
