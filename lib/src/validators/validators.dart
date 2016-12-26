library jaguar_validate.src.validators;

import 'dart:async';
import 'package:jaguar_validate/src/core/core.dart';

part 'does_not_have_consecuitive_repeated_character.dart';
part 'has_len.dart';
part 'has_len_greater_than.dart';
part 'has_len_in_range.dart';
part 'has_len_less_than.dart';
part 'has_special_character.dart';
part 'is_alpha.dart';
part 'is_alphanumeric.dart';
part 'is_email.dart';
part 'is_equal.dart';
part 'is_greater_than.dart';
part 'is_in_range.dart';
part 'is_less_than.dart';
part 'is_not_empty.dart';
part 'is_numeric.dart';
part 'matches_regex.dart';
part 'not_null.dart';
part 'valid_if.dart';
part 'validate_validatable.dart';

RegExp _creditCard = new RegExp(
    r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$');

RegExp _int = new RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
RegExp _float =
    new RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
RegExp _hexadecimal = new RegExp(r'^[0-9a-fA-F]+$');
RegExp _hexcolor = new RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$');

PropertyValidationErrors _mkPEr(String field, String msg) =>
    new PropertyValidationErrors(field)..add(new ValidationError(msg));

PropertyValidationErrors _mkPErL(String field, List<String> msges) {
  PropertyValidationErrors ret = new PropertyValidationErrors(field);
  msges.forEach((String msg) => ret.add(new ValidationError(msg)));
  return ret;
}
