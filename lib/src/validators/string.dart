import 'package:jaguar_validate/jaguar_validate.dart';

final _emailRegexp = RegExp(
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

Validator<String> isNotEmpty({bool trim = false}) {
  return (String value) {
    if (value == null) return null;

    if (trim) value = value.trim();
    if (value == null || value.isEmpty) {
      return ['should not be empty'];
    }
    return null;
  };
}

Validator<String> isEmail() {
  return (String value) {
    if (value == null) return null;

    if (!_emailRegexp.hasMatch(value.toLowerCase()))
      return ['not a valid email'];
    return null;
  };
}

Validator<String> hasLength(int length) {
  return (String value) {
    if (value == null) return null;

    if (value.runes.length != length) return ['must have length $length'];
    return null;
  };
}

Validator<String> hasMinLength(int length) {
  return (String value) {
    if (value == null) return null;

    if (value.runes.length < length)
      return ['should be at least $length characters long'];
    return null;
  };
}

Validator<String> hasMaxLength(int length) {
  return (String value) {
    if (value == null) return null;

    if (value.runes.length > length)
      return ['cannot be longer than $length characters'];
    return null;
  };
}

Validator<String> hasLengthInRange(int min, int max) {
  return (String value) {
    if (value == null) return null;

    if (value.runes.length < min || value.runes.length > max)
      return ['length should be in range [$min, $max]'];
    return null;
  };
}

final _anAlphabetRegexp = RegExp(r'[a-zA-Z]');

List hasAnAlphabet(String value) {
  if (value == null) return null;

  if (!_anAlphabetRegexp.hasMatch(value)) {
    return ['should contain at least one alphabet'];
  }
  return null;
}

final _aSpecialCharacterRegexp = RegExp(r'[^A-Za-z0-9 ]');

List hasASpecialChar(String value) {
  if (value == null) return null;

  if (!_aSpecialCharacterRegexp.hasMatch(value)) {
    return ['should contain at least one special character'];
  }
  return null;
}

final _isAlphaRegexp = RegExp(r'^[a-zA-Z]+$');

List isAlpha(String value) {
  if (value == null) return null;

  if (!_isAlphaRegexp.hasMatch(value)) {
    return ['should contain only alphabets'];
  }
  return null;
}

final _alphaNumericRegexp = RegExp(r'^[a-zA-Z0-9]+$');

List isAlphaNumeric(String value) {
  if (value == null) return null;

  if (!_alphaNumericRegexp.hasMatch(value)) {
    return ['should contain only alphabets and numbers'];
  }
  return null;
}

final _numericRegexp = RegExp(r'^[0-9]+$');

List isNumeric(String value) {
  if (value == null) return null;

  if (!_numericRegexp.hasMatch(value)) {
    return ['should contain only numbers'];
  }
  return null;
}

final _aNumberRegexp = RegExp(r'[0-9]');

List hasANumber(String value) {
  if (value == null) return null;

  if (!_aNumberRegexp.hasMatch(value)) {
    return ['should contain at least one number'];
  }
  return null;
}

Validator<String> doesNotHaveConsecutiveRepeatedChars(
    {int allowedRepeats = 3}) {
  final regexp = RegExp(r'(.)\1{' + (allowedRepeats + 1).toString() + r',}');
  return (String value) {
    if (value == null) return null;

    if (regexp.hasMatch(value)) {
      return [
        'should not have same character repeating consecutively more than ${allowedRepeats} times'
      ];
    }

    return null;
  };
}

Validator<String> matchesRegExp(RegExp regexp, {String message}) {
  if (message == null) message = 'should match pattern "${regexp.pattern}"';
  return (String value) {
    if (value == null) return null;

    if (!regexp.hasMatch(value)) {
      return [message];
    }
    return null;
  };
}

final _integerRegexp = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
final _floatRegexp =
    RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
final _hexadecimalRegexp = RegExp(r'^[0-9a-fA-F]+$');
final _hexcolorRegexp = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
