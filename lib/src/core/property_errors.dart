part of jaguar_validate.src.core;

class PropertyValidationErrors implements ValidationErrors {
  final String field;

  final List<ValidationError> _errors = [];

  PropertyValidationErrors(this.field);

  List<ValidationError> get errors => _errors.toList();

  bool get hasErrors => _errors.length != 0;

  void add(ValidationError error) {
    _errors.add(error);
  }

  List<String> toList() =>
      _errors.map((ValidationError v) => v.toString()).toList();
}