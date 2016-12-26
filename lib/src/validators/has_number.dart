part of jaguar_validate.src.validators;

RegExp _containsNumber = new RegExp(r'[0-9]');

class HasNumber implements FieldValidator<String> {
  final bool whenNotNull;

  const HasNumber({this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, String param) async {
    if (param == null) {
      if (whenNotNull) {
        return _mkPErL(field, []);
      } else {
        return _mkPEr(field, '$field cannot be null!');
      }
    }

    if (!_containsNumber.hasMatch(param.toLowerCase())) {
      return _mkPEr(field, '$field does not contain special character!');
    }

    return _mkPErL(field, []);
  }
}
