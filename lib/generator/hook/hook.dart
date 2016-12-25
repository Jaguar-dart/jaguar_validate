library jaguar_serializer.generator.hook;

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'package:jaguar_validate/jaguar_validate.dart';

import 'package:jaguar_validate/generator/parser/parser.dart';
import 'package:jaguar_validate/generator/model/model.dart';
import 'package:jaguar_validate/generator/writer/writer.dart';

import 'package:source_gen_help/source_gen_help.dart';

/// source_gen hook to generate serializer
class ValidatorGenerator extends GeneratorForAnnotation<GenValidator> {
  const ValidatorGenerator();

  /// This method is called when build finds an element with
  /// [GenSerializer] annotation.
  ///
  /// [element] is the element annotated with [Api]
  /// [api] is an instantiation of the [Api] annotation
  @override
  Future<String> generateForAnnotatedElement(
      Element element, GenValidator api, BuildStep buildStep) async {
    if (element is! ClassElement) {
      throw new Exception(
          "GenValidator annotation can only be defined on a class.");
    }

    ClassElement classElement = element;
    String className = classElement.name;

    print("Generating validator for $className ...");

    ModelInfo info = parse(new ClassElementWrap(classElement));

    Writer writer = new Writer(info);

    return writer.toString();
  }
}
