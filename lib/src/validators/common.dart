import 'package:jaguar_validate/jaguar_validate.dart';

List isNotNull(dynamic value) {
  if(value == null) return ['should not be null'];
  return null;
}