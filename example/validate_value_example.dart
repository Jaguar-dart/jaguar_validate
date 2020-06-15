import 'package:jaguar_validate/jaguar_validate.dart';

void main() {
  print(validateValue('hello', [isNotNull(), hasLength(5)]));
  print(validateValue('hello world!', [isNotNull(), hasLength(5)]));
}
