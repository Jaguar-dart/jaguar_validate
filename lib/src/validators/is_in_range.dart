part of jaguar_validate.src.validators;

class IsInRange implements FieldValidator {
  final num min;

  final num max;

  final bool whenNotNull;

  const IsInRange(this.min, this.max, {this.whenNotNull: false});

  Future<PropertyValidationErrors> validate(String field, dynamic param) async {
    if (param is int || param is double || param is num) {
      if (param < min) {
        return _mkPEr(field, '$field must be greater than $min!');
      }
      if (param > max) {
        return _mkPEr(field, '$field must be less than $max!');
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
