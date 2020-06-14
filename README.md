# jaguar_validate

A super simple fluent Validator framework for Dart

## Usage

A simple usage example:

```dart
library jaguar_validate.example.simple;

import 'package:jaguar_validate/jaguar_validate.dart';

class Author {
  String name;

  String email;

  int age;

  Author.make(this.name, this.email, this.age);

  ObjectErrors validate() {
    ObjectErrors errors = ObjectErrors();
    Validate.string
        .isNotNull()
        .isNotEmpty(trim: true)
        .startsWithAlpha()
        .hasLengthLessThan(10)
        .setErrors(name, 'name', errors);
    Validate.string
        .isNotNull()
        .isNotEmpty(trim: true)
        .isEmail()
        .setErrors(email, 'email', errors);
    Validate.int
        .isNotNull()
        .isInRange(20, 30)
        .setErrors(age, 'age', errors);
    return errors;
  }
}

main() {
  Author author = Author.make('Mark', 'mark@books.com', 28);

  ObjectErrors e = author.validate();
  print(e.toJson());
  print(e.hasErrors);
  //=> {}
  //=> false

  author.age = 35;
  e = author.validate();
  print(e.toJson());
  print(e.hasErrors);
  //=> {age: [should be in range [20, 30]!]}
  //=> true

  author.name = '5Mark';
  e = author.validate();
  print(e.toJson());
  print(e.hasErrors);
  //=> {name: [should start with an alphabet!], age: [should be in range [20, 30]!]}
  //=> true

  author.email = 'tejainece@';
  e = author.validate();
  print(e.toJson());
  print(e.hasErrors);
  //=> {name: [should start with an alphabet!], email: [is not an email!], age: [should be in range [20, 30]!]}
  //=> true
}
```
