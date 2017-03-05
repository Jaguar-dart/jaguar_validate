part of jaguar_validate.src.validators;

class ValidateValidatable implements FieldValidator<Validatable> {
  final bool whenNotNull;

  const ValidateValidatable({this.whenNotNull: false});

  Future<ValidationErrors> validate(String field, Validatable param) async {
    if (param == null) {
      if (whenNotNull) {
        return new ObjectValidationErrors(field);
      } else {
        PropertyValidationErrors err = new PropertyValidationErrors(field);
        err.add(new ValidationError('$field cannot be null!'));
        return err;
      }
    }

    try {
      await param.validate();
    } on ValidationErrors catch (e) {
      if (e is ObjectValidationErrors) {
        e.field = field;
      }
      return e;
    }

    return new ObjectValidationErrors(field);
  }
}
