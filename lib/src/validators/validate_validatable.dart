part of jaguar_validate.src.validators;

class ValidateValidatable implements FieldValidator<Validatable> {
  final bool whenNotNull;

  const ValidateValidatable({this.whenNotNull: false});

  Future<ValidationErrors> validate(String field, Validatable param) async {
    ObjectValidationErrors errors = new ObjectValidationErrors(field);

    if(param == null) {
      if(whenNotNull) {
        return errors;
      } else {
        errors.addPErr('this', new ValidationError('$field cannot be null!'));
        return errors;
      }
    }

    try {
      await param.validate();
    } on ObjectValidationErrors catch (e) {
      errors = e;
      errors.field = field;
    }

    return errors;
  }
}