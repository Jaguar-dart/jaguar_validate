// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library jaguar_validate.example.simple;

import 'dart:convert';
import 'package:jaguar_validate/jaguar_validate.dart';

class Author {
  String name;

  String email;

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
    Validate.int.isNotNull().isInRange(20, 30).setErrors(age, 'age', errors);
    return errors;
  }
}

class Book {
  String name;

  Author author;

  List<Author> authors;

  Book(this.name, this.author, this.authors);

  ObjectErrors validate() {
    ObjectErrors errors = new ObjectErrors();
    Validate.string
        .isNotNull()
        .isNotEmpty(trim: true)
        .startsWithAlpha()
        .hasLengthLessThan(10)
        .setErrors(name, 'name', errors);
    errors.add('author', author.validate());
    errors.add('authors', {'0': authors.map((a) => a.validate()).toList()});
    return errors;
  }
}

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

  Book book = new Book('Fantastic beasts', author, [author, author]);
  e = book.validate();
  print(json.encode(e.toJson()));
}
