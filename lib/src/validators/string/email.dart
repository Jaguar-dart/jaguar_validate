part of 'string.dart';

class StringIsNotEmpty implements FieldValidator<String> {
  final bool trim;

  const StringIsNotEmpty({this.trim: false});

  dynamic validate(String param) {
    param = param.trim();
    if (param == null || param.isEmpty) {
      return 'should not be empty!';
    }
    return null;
  }
}

class IsEmail implements FieldValidator<String> {
  final bool whenNotNull;

  final dynamic msg;

  const IsEmail({this.whenNotNull: false, this.msg});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull)
        return null;
      else
        msg ?? 'cannot be null!';
    }
    if (!regex.hasMatch(param.toLowerCase())) return 'is not an email!';
    return null;
  }

  static RegExp regex = new RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
}

class StringHasLength implements FieldValidator<String> {
  final int length;

  const StringHasLength(this.length);

  dynamic validate(String param) {
    if (param.length != length) return 'must have length $length!';
    return null;
  }
}

class StringHasLengthGreaterThan implements FieldValidator<String> {
  final int length;

  const StringHasLengthGreaterThan(this.length);

  dynamic validate(dynamic param) {
    if (param.length <= length) {
      return 'should have length greater than $length!';
    }
    return null;
  }
}

class StringHasLengthLessThan implements FieldValidator<String> {
  final int length;

  const StringHasLengthLessThan(this.length);

  dynamic validate(dynamic param) {
    if (param.length >= length) {
      return 'should have length less than $length!';
    }
    return null;
  }
}

class StringHasLengthInRange implements FieldValidator<String> {
  final num min;

  final num max;

  final bool whenNotNull;

  const StringHasLengthInRange(this.min, this.max, {this.whenNotNull: false});

  dynamic validate(String param) {
    if (param.length < min || param.length > max) {
      return 'should have length in range [${min}, ${max}]!';
    }
    return null;
  }
}

class HasAnAlphabet implements FieldValidator<String> {
  final bool whenNotNull;

  const HasAnAlphabet({this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull)
        return null;
      else
        'should not be null!';
    }
    if (!regex.hasMatch(param.toLowerCase())) {
      return 'should contain an alphabet!';
    }
    return null;
  }

  static RegExp regex = new RegExp(r'[a-zA-Z]');
}

class HasASpecialChar implements FieldValidator<String> {
  final bool whenNotNull;

  const HasASpecialChar({this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }
    if (!regex.hasMatch(param.toLowerCase())) {
      return 'should contain a special character!';
    }
    return null;
  }

  static RegExp regex = new RegExp(r'[^A-Za-z0-9]');
}

class IsAlpha implements FieldValidator<String> {
  final bool whenNotNull;

  const IsAlpha({this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }
    if (!regex.hasMatch(param.toLowerCase())) {
      return 'should contain only alphabets!';
    }
    return null;
  }

  static RegExp regex = new RegExp(r'^[a-zA-Z]+$');
}

class IsAlphaNumeric implements FieldValidator<String> {
  final bool whenNotNull;

  const IsAlphaNumeric({this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }
    if (!regex.hasMatch(param.toLowerCase())) {
      return 'should be alphanumeric!';
    }
    return null;
  }

  static RegExp regex = new RegExp(r'^[a-zA-Z0-9]+$');
}

class IsNumeric implements FieldValidator<String> {
  final bool whenNotNull;

  const IsNumeric({this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }
    if (!_numeric.hasMatch(param.toLowerCase())) {
      return 'should be a number!';
    }
    return null;
  }

  static RegExp _numeric = new RegExp(r'^-?[0-9]+$');
}

class HasADigit implements FieldValidator<String> {
  final bool whenNotNull;

  const HasADigit({this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }
    if (!regex.hasMatch(param.toLowerCase())) {
      return 'should contain a number!';
    }
    return null;
  }

  static RegExp regex = new RegExp(r'[0-9]');
}

class DoesNotHaveSpace implements FieldValidator<String> {
  final bool whenNotNull;

  const DoesNotHaveSpace({this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }
    if (param.contains(' ')) return 'should not contain a space!';
    return null;
  }
}

class StartsWithAlpha implements FieldValidator<String> {
  final bool whenNotNull;

  const StartsWithAlpha({this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }
    if(param.length == 0) return 'should not be empty!';
    final int first = param.codeUnitAt(0);
    if (first >= 97 && first <= 122) return null;
    if(first >= 65 && first <= 90) return null;
    return 'should start with an alphabet!';
  }

  static RegExp regex = new RegExp(r'[a-zA-Z]');
}

class MatchesRegEx implements FieldValidator<String> {
  final String pattern;

  final bool whenNotNull;

  const MatchesRegEx(this.pattern, {this.whenNotNull: false});

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }
    RegExp re = new RegExp(pattern);
    if (!re.hasMatch(param)) {
      return 'should match the pattern!';
    }
    return null;
  }
}

class DoesNotHaveConsecutiveRepeatedChars implements FieldValidator<String> {
  final bool whenNotNull;

  final int allowedRepeats;

  final RegExp regex;

  DoesNotHaveConsecutiveRepeatedChars(
      {this.whenNotNull: false, this.allowedRepeats: 0})
      : regex = new RegExp(r'(.)\1{' + (allowedRepeats + 1).toString() + ',}');

  dynamic validate(String param) {
    if (param == null) {
      if (whenNotNull) {
        return null;
      } else {
        return 'should not be null!';
      }
    }

    if (!regex.hasMatch(param.toLowerCase())) {
      return 'Should not have same character repeating consecutively more than ${allowedRepeats} times!';
    }

    return null;
  }
}
