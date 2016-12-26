part of jaguar_validate.src.validators;

class DoesNotHaveConsecutiveRepeatedChars implements FieldValidator<String> {
  final bool whenNotNull;

  final int allowedRepeats;

  const DoesNotHaveConsecutiveRepeatedChars(
      {this.whenNotNull: false, this.allowedRepeats: 0});

  Future<PropertyValidationErrors> validate(String field, String param) async {
    if (param == null) {
      if (whenNotNull) {
        return _mkPErL(field, []);
      } else {
        return _mkPEr(field, '$field cannot be null!');
      }
    }

    RegExp pattern =
        new RegExp(r'(.)\1{' + (allowedRepeats + 1).toString() + ',}');

    if (!pattern.hasMatch(param.toLowerCase())) {
      return _mkPEr(field, '$field is not alpha!');
    }

    return _mkPErL(field, []);
  }
}
