part of jaguar_validate.src.validators;

RegExp _containsAlpha = new RegExp(r'[a-zA-Z]');

class HasAlpha implements FieldValidator<String> {
  final bool whenNotNull;

  HasAlpha HasNumber({this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, String param) async {
    if (param == null) {
      if (whenNotNull) {
        return _mkPErL(field, []);
      } else {
        return _mkPEr(field, '$field cannot be null!');
      }
    }

    if (!_containsAlpha.hasMatch(param.toLowerCase())) {
      return _mkPEr(field, '$field does not contain alphabets!');
    }

    return _mkPErL(field, []);
  }
}
