import 'package:jaguar_validate/jaguar_validate.dart';

class NumValidator {
  final List<FieldValidator<num>> validators = <FieldValidator<num>>[];

  NumValidator isNotNull() {
    validators.add(new IsNotNull<num>());
    return this;
  }

  NumValidator isEqual(num value) {
    validators.add(new IsEqual<num>(value));
    return this;
  }

  NumValidator isGreaterThan(num value) {
    validators.add(new IsGreaterThan(value));
    return this;
  }

  NumValidator isLessThan(num value) {
    validators.add(new IsLessThan(value));
    return this;
  }

  NumValidator isInRange(num min, num max) {
    validators.add(new IsInRange(min, max));
    return this;
  }

  List<dynamic> validate(num value, {bool failFast: true}) {
    List<dynamic> ret = [];
    for (FieldValidator<num> v in validators) {
      var e = v.validate(value);
      if (e != null) {
        ret.add(e);
        break;
      }
    }
    return ret;
  }

  void setErrors(num value, String field, ObjectErrors object) {
    List<dynamic> errors = validate(value);
    if(errors.length != 0) object.add(field, errors);
  }
}

class IntValidator {
  final List<FieldValidator<int>> validators = <FieldValidator<int>>[];

  IntValidator isNotNull() {
    validators.add(new IsNotNull<int>());
    return this;
  }

  IntValidator isEqual(num value) {
    validators.add(new IsEqual<int>(value));
    return this;
  }

  IntValidator isGreaterThan(num value) {
    validators.add(new IsGreaterThan<int>(value));
    return this;
  }

  IntValidator isLessThan(num value) {
    validators.add(new IsLessThan<int>(value));
    return this;
  }

  IntValidator isInRange(num min, num max) {
    validators.add(new IsInRange<int>(min, max));
    return this;
  }

  List<dynamic> validate(num value, {bool failFast: true}) {
    List<dynamic> ret = [];
    for (FieldValidator<int> v in validators) {
      var e = v.validate(value);
      if (e != null) {
        ret.add(e);
        break;
      }
    }
    return ret;
  }

  void setErrors(int value, String field, ObjectErrors object) {
    List<dynamic> errors = validate(value);
    if(errors.length != 0) object.add(field, errors);
  }
}

class DoubleValidator {
  final List<FieldValidator<double>> validators = <FieldValidator<double>>[];

  DoubleValidator isNotNull() {
    validators.add(new IsNotNull<double>());
    return this;
  }

  DoubleValidator isEqual(num value) {
    validators.add(new IsEqual<double>(value));
    return this;
  }

  DoubleValidator isGreaterThan(num value) {
    validators.add(new IsGreaterThan<double>(value));
    return this;
  }

  DoubleValidator isLessThan(num value) {
    validators.add(new IsLessThan<double>(value));
    return this;
  }

  DoubleValidator isInRange(num min, num max) {
    validators.add(new IsInRange<double>(min, max));
    return this;
  }

  List<dynamic> validate(double value, {bool failFast: true}) {
    List<dynamic> ret = [];
    for (FieldValidator<double> v in validators) {
      var e = v.validate(value);
      if (e != null) {
        ret.add(e);
        break;
      }
    }
    return ret;
  }

  void setErrors(double value, String field, ObjectErrors object) {
    List<dynamic> errors = validate(value);
    if(errors.length != 0) object.add(field, errors);
  }
}

class IsGreaterThan<T extends num> implements FieldValidator<T> {
  final num value;

  const IsGreaterThan(this.value);

  dynamic validate(num param) {
    if (param <= value) return 'must be greater than $value!';
    return null;
  }
}

class IsInRange<T extends num> implements FieldValidator<T> {
  final num min;

  final num max;

  final bool whenNotNull;

  const IsInRange(this.min, this.max, {this.whenNotNull: false});

  dynamic validate(dynamic param) {
    if (param < min || param > max) {
      return 'should be in range [$min, $max]!';
    }
    return null;
  }
}

class IsLessThan<T extends num> implements FieldValidator<T> {
  final num value;

  const IsLessThan(this.value);

  dynamic validate(num param) {
    if (param >= value) {
      return 'should be less than $value!';
    }
    return null;
  }
}
