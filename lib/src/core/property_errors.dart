part of jaguar_validate.src.core;

class PropertyValidationErrors implements ValidationErrors {
  final String field;

  final List<ValidationError> _errors = [];

  UnmodifiableListView<ValidationError> _errorsUnmod;

  PropertyValidationErrors(this.field,
      [List<ValidationError> errs = const []]) {
    _errors.addAll(errs);
    _errorsUnmod = new UnmodifiableListView(_errors);
  }

  List<PropertyValidationErrors> get properties =>
      <PropertyValidationErrors>[this];

  UnmodifiableListView<ValidationError> get errors => _errorsUnmod;

  bool get hasErrors => _errors.length != 0;

  void add(ValidationError error) => _errors.add(error);

  void addAll(List<ValidationError> errors) => _errors.addAll(errors);

  List<String> toList() =>
      _errors.map((ValidationError v) => v.toString()).toList();
}
