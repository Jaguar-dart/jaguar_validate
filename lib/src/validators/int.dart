import 'package:jaguar_validate/jaguar_validate.dart';

String _isGreaterThanErrFunc(int min) => 'should be greater than $min';

ValidationRule<int> isGreaterThan(int min, {err = _isGreaterThanErrFunc}) {
  return (int value) {
    if (value == null) return null;

    if (value <= min) {
      return [err is Function ? err(min) : err];
    }

    return null;
  };
}

String _isLessThanErrFunc(int max) => 'should be less than $max';

ValidationRule<int> isLessThan(int max, {err = _isLessThanErrFunc}) {
  return (int value) {
    if (value == null) return null;

    if (value >= max) {
      return [err is Function ? err(max) : err];
    }

    return null;
  };
}

String _isInRangeErrFunc(int min, int max) => 'should be in range [$min, $max]';

ValidationRule<int> isInRange(int min, int max, {err = _isInRangeErrFunc}) {
  return (int value) {
    if (value == null) return null;

    if (value < min || value > max) {
      return [err is Function ? err(min, max) : err];
    }

    return null;
  };
}

ValidationRule<int> isPositive({err = 'should be positive'}) {
  return (int value) {
    if (value == null) return null;

    if (value < 0) {
      return [err];
    }

    return null;
  };
}

ValidationRule<int> isNegative({err = 'should be negative'}) {
  return (int value) {
    if (value == null) return null;

    if (value >= 0) {
      return [err];
    }

    return null;
  };
}

ValidationRule<int> isOdd({err = 'should be odd'}) {
  return (int value) {
    if (value == null) return null;

    if (!value.isOdd) {
      return [err];
    }

    return null;
  };
}

ValidationRule<int> isEven({err = 'should be even'}) {
  return (int value) {
    if (value == null) return null;

    if (!value.isEven) {
      return [err];
    }

    return null;
  };
}
