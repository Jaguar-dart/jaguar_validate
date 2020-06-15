import 'package:jaguar_validate/jaguar_validate.dart';

final _emailRegexp = RegExp(
    r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

Validator<String> isNotEmpty({bool trim = false, err = 'should not be empty'}) {
  return (String value) {
    if (value == null) return null;

    if (trim) value = value.trim();
    if (value == null || value.isEmpty) {
      return [err];
    }
    return null;
  };
}

Validator<String> isEmailAddress({err = 'not a valid email address'}) {
  return (String value) {
    if (value == null) return null;

    if (!_emailRegexp.hasMatch(value.toLowerCase())) return [err];
    return null;
  };
}

String _hasLengthErrFunc(int expected, int actual) =>
    'must have length $expected';

Validator<String> hasLength(int length, {err = _hasLengthErrFunc}) {
  return (String value) {
    if (value == null) return null;

    if (value.runes.length != length)
      return [err is Function ? err(length, value.runes.length) : err];
    return null;
  };
}

String _hasMinLengthErrFunction(int min, int actual) =>
    'should be at least $min characters long';

Validator<String> hasMinLength(int length, {err = _hasMinLengthErrFunction}) {
  return (String value) {
    if (value == null) return null;

    if (value.runes.length < length)
      return [err is Function ? err(length, value.runes.length) : err];
    return null;
  };
}

String _hasMaxLengthErrFunction(int max, int actual) =>
    'cannot be longer than $max characters';

Validator<String> hasMaxLength(int length, {err = _hasMaxLengthErrFunction}) {
  return (String value) {
    if (value == null) return null;

    if (value.runes.length > length)
      return [err is Function ? err(length, value.runes.length) : err];
    return null;
  };
}

String _hasLengthInRangeErrFunction(int min, int max, int actual) =>
    'length should be in range [$min, $max]';

Validator<String> hasLengthInRange(int min, int max,
    {err = _hasLengthInRangeErrFunction}) {
  return (String value) {
    if (value == null) return null;

    int length = value.runes.length;

    if (length < min || length > max)
      return [err is Function ? err(min, max, length) : err];
    return null;
  };
}

final _anAlphabetRegexp = RegExp(r'[a-zA-Z]');

Validator<String> hasAnAlphabet(
    {err = 'should contain at least one alphabet'}) {
  return (String value) {
    if (value == null) return null;

    if (!_anAlphabetRegexp.hasMatch(value)) {
      return [err];
    }
    return null;
  };
}

final _aSpecialCharacterRegexp = RegExp(r'[^A-Za-z0-9 ]');

Validator<String> hasASpecialChar(
    {err = 'should contain at least one special character'}) {
  return (String value) {
    if (value == null) return null;

    if (!_aSpecialCharacterRegexp.hasMatch(value)) {
      return [err];
    }
    return null;
  };
}

final _isAlphaRegexp = RegExp(r'^[a-zA-Z]+$');

Validator<String> isAlpha({err = 'should contain only alphabets'}) {
  return (String value) {
    if (value == null) return null;

    if (!_isAlphaRegexp.hasMatch(value)) {
      return [err];
    }
    return null;
  };
}

final _alphaNumericRegexp = RegExp(r'^[a-zA-Z0-9]+$');

Validator<String> isAlphaNumeric(
    {err = 'should contain only alphabets and numbers'}) {
  return (String value) {
    if (value == null) return null;

    if (!_alphaNumericRegexp.hasMatch(value)) {
      return [err];
    }
    return null;
  };
}

final _numericRegexp = RegExp(r'^[0-9]+$');

Validator<String> isNumeric({err = 'should contain only numbers'}) {
  return (String value) {
    if (value == null) return null;

    if (!_numericRegexp.hasMatch(value)) {
      return [err];
    }
    return null;
  };
}

final _aNumberRegexp = RegExp(r'[0-9]');

Validator<String> hasANumber([err = 'should contain at least one number']) {
  return (String value) {
    if (value == null) return null;

    if (!_aNumberRegexp.hasMatch(value)) {
      return [err];
    }
    return null;
  };
}

String _maxRepeatedCharactersErrFunction(int allowedRepeats) =>
    'should not have same character repeating consecutively more than ${allowedRepeats} times';

Validator<String> maxRepeatedCharacters(
    {int allowedRepeats = 3, err = _maxRepeatedCharactersErrFunction}) {
  final regexp = RegExp(r'(.)\1{' + (allowedRepeats + 1).toString() + r',}');
  return (String value) {
    if (value == null) return null;

    if (regexp.hasMatch(value)) {
      return [err is Function ? err(allowedRepeats) : err];
    }

    return null;
  };
}

String _matchesRegExpErrFunction(RegExp regexp) =>
    'should match pattern "${regexp.pattern}"';

Validator<String> matchesRegExp(RegExp regexp,
    {err = _matchesRegExpErrFunction}) {
  return (String value) {
    if (value == null) return null;

    if (!regexp.hasMatch(value)) {
      return [err is Function ? err(regexp) : err];
    }
    return null;
  };
}

final _integerRegexp = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
final _floatRegexp =
    RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
final _hexadecimalRegexp = RegExp(r'^[0-9a-fA-F]+$');
final _hexcolorRegexp = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');
