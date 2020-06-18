import 'package:jaguar_validate/jaguar_validate.dart';

ValidationRule<dynamic> isNotNull({err = 'should not be null'}) {
  return (dynamic value) {
    if (value == null) return [err];
    return null;
  };
}
