# jaguar_validate

A simple, source generated Validator framework

## Usage

A simple usage example:

```dart
import 'package:jaguar_validate/jaguar_validate.dart';

class User implements Validated {
  User.make(this.name, this.email, this.quote, this.age);

  @HasLengthInRange(1, 10)
  String name;

  @IsEmail()
  String email;

  @HasLengthInRange(15, 75)
  String quote;

  @IsInRange(20, 30)
  int age;
}

main() async {
  try {
    User user = new User.make(
        'teja', 'tejainece@gmail.com', 'Jaguar cofounder', 27);
    await user.validate();
  } on ValidationErrors catch(e) {
    print(e);
  }
}
```
