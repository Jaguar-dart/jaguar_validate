import 'package:jaguar_validate/jaguar_validate.dart';

part 'email.dart';

class StringValidator {
  final List<FieldValidator<String>> validators = <FieldValidator<String>>[];

  StringValidator isNotEmpty({bool trim: false}) {
    validators.add(new StringIsNotEmpty(trim: trim));
    return this;
  }

  StringValidator isNotNull() {
    validators.add(new IsNotNull<String>());
    return this;
  }

  StringValidator isEmail() {
    validators.add(new IsEmail());
    return this;
  }

  StringValidator hasLength(int length) {
    validators.add(new StringHasLength(length));
    return this;
  }

  StringValidator hasLengthGreaterThan(int length) {
    validators.add(new StringHasLengthGreaterThan(length));
    return this;
  }

  StringValidator hasLengthLessThan(int length) {
    validators.add(new StringHasLengthLessThan(length));
    return this;
  }

  StringValidator hasLengthInRange(int min, int max) {
    validators.add(new StringHasLengthInRange(min, max));
    return this;
  }

  StringValidator hasAnAlphabet() {
    validators.add(new HasAnAlphabet());
    return this;
  }

  StringValidator hasASpecialChar() {
    validators.add(new HasASpecialChar());
    return this;
  }

  StringValidator isAlpha() {
    validators.add(new IsAlpha());
    return this;
  }

  StringValidator isAlphaNumeric() {
    validators.add(new IsAlphaNumeric());
    return this;
  }

  StringValidator isNumeric() {
    validators.add(new IsNumeric());
    return this;
  }

  StringValidator hasADigit() {
    validators.add(new HasADigit());
    return this;
  }

  StringValidator doesNotHaveSpace() {
    validators.add(new DoesNotHaveSpace());
    return this;
  }

  StringValidator startsWithAlpha() {
    validators.add(new StartsWithAlpha());
    return this;
  }

  StringValidator matches(String pattern) {
    validators.add(new MatchesRegEx(pattern));
    return this;
  }

  StringValidator doesNotHaveConsecutiveRepeatedChars(
      [int allowedRepeats = 0]) {
    validators.add(new DoesNotHaveConsecutiveRepeatedChars(
        allowedRepeats: allowedRepeats));
    return this;
  }

  List<dynamic> validate(String value, {bool failFast: true}) {
    List<dynamic> ret = [];
    for (FieldValidator<String> v in validators) {
      var e = v.validate(value);
      if (e != null) {
        ret.add(e);
        break;
      }
    }
    return ret;
  }

  void setErrors(String value, String field, ObjectErrors object) {
    List<dynamic> errors = validate(value);
    if(errors.length != 0) object.add(field, errors);
  }
}
