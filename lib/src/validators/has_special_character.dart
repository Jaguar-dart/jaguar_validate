part of jaguar_validate.src.validators;

RegExp _containsSpecialChar = new RegExp(r'[^A-Za-z0-9]');

class HasSpecialChar implements FieldValidator<String> {
  final bool whenNotNull;

  const HasSpecialChar({this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, String param) async {
    if (param == null) {
      if (whenNotNull) {
        return _mkPErL(field, []);
      } else {
        return _mkPEr(field, '$field cannot be null!');
      }
    }

    if (!_containsSpecialChar.hasMatch(param.toLowerCase())) {
      return _mkPEr(field, '$field does not contain special character!');
    }

    return _mkPErL(field, []);
  }
}
