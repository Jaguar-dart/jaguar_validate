part of jaguar_validate.src.validators;

class HasLenInRange implements FieldValidator {
  final num min;

  final num max;

  final bool whenNotNull;

  const HasLenInRange(this.min, this.max, {this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is String || param is List || param is Map || param is Set) {
      if (param.length < min) {
        return _mkPEr(field, '$field must have length greater than $min!');
      }

      if (param.length > max) {
        return _mkPEr(field, '$field must have length less than $max!');
      }
    } else {
      if (param == null && whenNotNull) {
        //Throw no error if whenNotNull is true
      } else {
        return _mkPEr(field, '$field must be in range [$min, $max]!');
      }
    }

    return _mkPErL(field, []);
  }
}