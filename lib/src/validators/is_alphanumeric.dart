part of jaguar_validate.src.validators;

RegExp _alphanumeric = new RegExp(r'^[a-zA-Z0-9]+$');

class IsAlphaNumeric implements FieldValidator<String> {
  final bool whenNotNull;

  const IsAlphaNumeric({this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, String param) async {
    if(param == null) {
      if(whenNotNull) {
        return _mkPErL(field, []);
      } else {
        return _mkPEr(field, '$field cannot be null!');
      }
    }

    if(!_alphanumeric.hasMatch(param.toLowerCase())) {
      return _mkPEr(field, '$field is not alphanumeric!');
    }

    return _mkPErL(field, []);
  }
}