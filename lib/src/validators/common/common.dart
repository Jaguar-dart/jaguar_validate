import 'package:jaguar_validate/jaguar_validate.dart';

class IsEqual<FieldType> implements FieldValidator<FieldType> {
  final FieldType to;

  const IsEqual(this.to);

  dynamic validate(FieldType param) {
    if (param is! FieldType || param != to) {
      return 'should be equal to $to!';
    }
    return null;
  }
}

class IsNotNull<T> implements FieldValidator<T> {
  const IsNotNull();

  dynamic validate(T param) {
    if (param == null) {
      return 'should not be null!';
    }
    return null;
  }
}