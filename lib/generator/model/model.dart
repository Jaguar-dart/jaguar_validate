library jaguar_serializer.generator.parser.model;

class FieldValidatorInfo {
  final String name;

  final String type;

  final String field;

  final String instantiation;

  FieldValidatorInfo(this.name, this.type, this.field, this.instantiation);
}

class ModelInfo {
  final String name;

  final List<FieldValidatorInfo> validators = [];

  ModelInfo(this.name);
}
