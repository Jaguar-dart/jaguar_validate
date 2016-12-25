part of jaguar_validate.src.validators;

RegExp _alpha = new RegExp(r'^[a-zA-Z]+$');

class IsAlpha implements FieldValidator<String> {
  final bool whenNotNull;

  const IsAlpha({this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, String param) async {
    if (param == null) {
      if (whenNotNull) {
        return _mkPErL(field, []);
      } else {
        return _mkPEr(field, '$field cannot be null!');
      }
    }

    if (!_alpha.hasMatch(param.toLowerCase())) {
      return _mkPEr(field, '$field is not alpha!');
    }

    return _mkPErL(field, []);
  }
}
