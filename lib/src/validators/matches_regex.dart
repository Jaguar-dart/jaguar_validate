part of jaguar_validate.src.validators;

class MatchesRegEx implements FieldValidator<String> {
  final String pattern;

  final bool whenNotNull;

  const MatchesRegEx(this.pattern, {this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, String param) async {
    if (param == null) {
      if (whenNotNull) {
        return _mkPErL(field, []);
      } else {
        return _mkPEr(field, '$field cannot be null!');
      }
    }

    RegExp re = new RegExp(pattern);
    if (!re.hasMatch(param)) {
      return _mkPEr(field, '$field does not match pattern!');
    }

    return _mkPErL(field, []);
  }
}
