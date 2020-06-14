import 'package:jaguar_validate/jaguar_validate.dart';

List<String> isNotNull(dynamic value) {
  if(value == null) return ['should not be null'];
  return null;
}