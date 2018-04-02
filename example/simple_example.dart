// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library jaguar_validate.example.simple;

import 'package:jaguar_validate/jaguar_validate.dart';

class Author {
  String name;

  String email;

  @IsInRange(20, 30)
  int age;

  Author.make(this.name, this.email, this.age);

  ObjectErrors validate() {
    ObjectErrors errors = new ObjectErrors();
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

/*
class Book extends _BookValidator {
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
*/

main() {
  Author author = new Author.make('Mark', 'mark@books.com', 28);

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

  /*
    String abstract = """
    Whatever is abstract. Whatever maybe. Whatever could be an abstract.
    Scientific papers are usually dumb page fillers.
    """;
    Author author = new Author.make('Mark', 'mark@books.com', 35);
    Book book = new Book.make('Fantastic beasts', author, abstract, 100, 250);
    book.validate();
  */
}
