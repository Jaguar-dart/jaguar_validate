part of jaguar_validate.src.core;

class ObjectValidator {
  final List<ValidatableField> _fields = [];

  ObjectValidator f<FieldType>(
      FieldValidator<FieldType> validator, String field, FieldType param) {
    _fields.add(new ValidatableField(field, param, validator));

    return this;
  }

  ObjectValidator add(ValidatableField field) {
    _fields.add(field);

    return this;
  }

  ObjectValidator addAll(List<ValidatableField> fields) {
    _fields.addAll(fields);

    return this;
  }

  Future<ObjectValidationErrors> validate() async {
    ObjectValidationErrors ret = new ObjectValidationErrors(null);

    for (ValidatableField v in _fields) {
      ValidationErrors err = await v.validator.validate(v.field, v.value);

      if (err.hasErrors) {
        if (err is ObjectValidationErrors) {
          ret.mergeOErr(err);
        } else if (err is PropertyValidationErrors) {
          ret.mergePErr(err);
        }
      }
    }

    return ret;
  }
}