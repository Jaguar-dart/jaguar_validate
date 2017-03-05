# jaguar_validate

A simple, source generated Validator framework

# Features

1. Both reflection and source generation are supported
2. Annotation based validators
3. Supports validation of nested objects

## Usage

A simple usage example:

```dart
library jaguar_validate.example.simple;

import 'dart:async';
import 'package:jaguar_validate/jaguar_validate.dart';

part 'simple_example.g.dart';

@GenValidator()
class Author extends _Author {
  @HasLenInRange(1, 10)
  String name;

  @IsEmail()
  String email;

  @IsInRange(20, 30)
  int age;

  Author.make(this.name, this.email, this.age);
}

@GenValidator()
class Book extends _Book {
  Book.make(this.name, this.author, this.abstract, this.pages, this.price);

  @HasLenInRange(1, 25)
  String name;

  @ValidateValidatable()
  Author author;

  @HasLenInRange(15, 1000)
  String abstract;

  @IsGreaterThan(0)
  int pages;

  @IsInRange(1, 200)
  int price;
}

main() async {
  try {
    String abstract = """
    Whatever is abstract. Whatever maybe. Whatever could be an abstract.
    Scientific papers are usually dumb page fillers.
    """;
    Author author = new Author.make('Mark', 'mark@books.com', 25);
    Book book = new Book.make('Fantastic beasts', author, abstract, 100, 100);
    await book.validate();
  } on ValidationErrors catch (e) {
    print(e);
  }
}
```
