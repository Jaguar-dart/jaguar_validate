library jaguar_serializer.generator.parser;

import 'package:analyzer/dart/element/element.dart';

import 'package:source_gen_help/source_gen_help.dart';

import 'package:jaguar_validate/generator/model/model.dart';

const NamedElement kTypeFieldValidator =
    const NamedElementImpl.Make('FieldValidator', 'jaguar_validate.src.core');

bool isValidator(AnnotationElementWrap annot) {
  ClassElementWrap w = annot.ancestorClazz;
  return w.isSubtypeOf(kTypeFieldValidator);
}

List<FieldValidatorInfo> _parseField(FieldElement el) {
  List<FieldValidatorInfo> ret = [];

  for (ElementAnnotation annot in el.metadata) {
    AnnotationElementWrap vf = new AnnotationElementWrap(annot);

    if (!isValidator(vf)) {
      continue;
    }

    FieldValidatorInfo f = new FieldValidatorInfo(
        el.name, el.type.name, el.name, vf.instantiationString);
    ret.add(f);
  }

  return ret;
}

ModelInfo parse(ClassElementWrap clazz) {
  ModelInfo ret = new ModelInfo(clazz.name);

  clazz.fields.forEach((FieldElement el) {
    List<FieldValidatorInfo> f = _parseField(el);

    ret.validators.addAll(f);
  });

  return ret;
}
