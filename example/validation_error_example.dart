import 'package:jaguar_validate/jaguar_validate.dart';

enum MyErrorCodes { shouldHave5Chars }

void main() {
  print(validateValue('hello world', [
    hasLength(5,
        err: (expected, actual) => ValidationError(
            code: MyErrorCodes.shouldHave5Chars.index,
            params: {'expected': expected, 'actual': actual}))
  ]));
}
