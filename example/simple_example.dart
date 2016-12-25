// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:jaguar_validate/jaguar_validate.dart';

class Author implements Validatable {
  @HasLenInRange(1, 10)
  String name;

  @IsEmail()
  String email;

  @IsInRange(20, 30)
  int age;

  Author.make(this.name, this.email, this.age);

  Future<Null> validate() async {
    ObjectValidator v = new ObjectValidator();

    v.f(new HasLenInRange(1, 10), 'name', name);
    v.f(new IsEmail(), 'email', email);
    v.f(new IsInRange(20, 30), 'age', age);

    ObjectValidationErrors err = await v.validate();

    if (err.hasErrors) {
      throw err;
    }
  }
}

class Book implements Validatable {
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

  Future<Null> validate() async {
    ObjectValidator v = new ObjectValidator();

    v.f(new HasLenInRange(1, 25), 'name', name);
    v.f(new ValidateValidatable(), 'author', author);
    v.f(new HasLenInRange(15, 1000), 'abstract', abstract);
    v.f(new IsGreaterThan(0), 'pages', pages);
    v.f(new IsInRange(1, 200), 'price', price);

    ObjectValidationErrors err = await v.validate();

    if (err.hasErrors) {
      throw err;
    }
  }
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
    print('here');
    print(e);
  }
}
