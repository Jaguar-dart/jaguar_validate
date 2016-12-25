part of jaguar_validate.src.validators;

RegExp _numeric = new RegExp(r'^-?[0-9]+$');

class IsNumeric implements FieldValidator<String> {
  final bool whenNotNull;

  const IsNumeric({this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, String param) async {
    if(param == null) {
      if(whenNotNull) {
        return _mkPErL(field, []);
      } else {
        return _mkPEr(field, '$field cannot be null!');
      }
    }

    if(!_numeric.hasMatch(param.toLowerCase())) {
      return _mkPEr(field, '$field is not a number!');
    }

    return _mkPErL(field, []);
  }
}