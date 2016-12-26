library jaguar_serializer.generator.writer;

import 'package:jaguar_validate/generator/model/model.dart';

class Writer {
  final ModelInfo info;

  StringBuffer _w = new StringBuffer();

  Writer(this.info) {
    _generate();
  }

  void _generate() {
    _w.writeln('abstract class _${info.name}Validator implements Validatable {');
    _w.writeln();

    _writeFields();

    _writeValidateMethod();

    _w.writeln('}');
  }

  void _writeFields() {
    Map<String, bool> written = {};
    for (FieldValidatorInfo item in info.validators) {
      if(written[item.field]) {
        continue;
      }

      written[item.field] = true;
      _w.writeln('${item.type} get ${item.field};');
      _w.writeln();
    }
  }

  void _writeValidateMethod() {
    _w.writeln(r'Future<Null> validate() async {');
    _w.writeln(r'ObjectValidator v = new ObjectValidator();');

    _w.writeln();

    for (FieldValidatorInfo item in info.validators) {
      _writeField(item);
    }

    _w.writeln();

    _w.writeln(r'ObjectValidationErrors err = await v.validate();');
    _w.writeln(r'if (err.hasErrors) {');
    _w.writeln(r'throw err;');
    _w.writeln(r'}');

    _w.writeln(r'}');
  }

  void _writeField(FieldValidatorInfo item) {
    _w.writeln(
        "v.f(new ${item.instantiation}, '${item.name}', ${item.field});");
  }

  String toString() => _w.toString();
}
