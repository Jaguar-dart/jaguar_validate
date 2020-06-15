// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library jaguar_validate.example.simple;

import 'package:jaguar_validate/jaguar_validate.dart';

class Author implements Validatable {
  String name;

  String email;

  int age;

  Author.make(this.name, this.email, this.age);

  ObjectErrors validate() {
    final errors = ObjectErrors();
    errors['name'] = validateValue(
        name, [isNotNull(), isNotEmpty(), isAlphaNumeric(), hasMaxLength(10)]);
    errors['email'] =
        validateValue(email, [isNotNull(), isNotEmpty(), isEmailAddress()]);
    errors['age'] = validateValue(age, [isNotNull()]);
    return errors;
  }
}

class Book implements Validatable {
  String name;

  Author author;

  List<Author> authors;

  Book(this.name, this.author, this.authors);

  ObjectErrors validate() {
    final errors = ObjectErrors();
    errors['name'] =
        validateValue(name, [isNotNull(), isNotEmpty(), hasMaxLength(10)]);
    errors['author'] = author.validate();
    errors['authors.@'] = validateValue(authors, [isNotNull()]);
    if(authors != null) {
      for(int i = 0; i < authors.length; i++) {
        errors['authors.$i'] = authors[i].validate();
      }
    }
    return errors;
  }
}

main() {
  Author author = Author.make('Mark', 'mark@books.com', 28);

  ObjectErrors e = author.validate();
  print(e.toJson());
  //=> {}

  author.age = null;
  e = author.validate();
  print(e.toJson());
  //=> {"age":["should not be null"]}

  author.name = ' Mark';
  e = author.validate();
  print(e.toJson());
  //=> {"name":["should contain only alphabets and numbers"],"age":["should not be null"]}

  author.email = 'tejainece@';
  e = author.validate();
  print(e.toJson());
  //=> {"name":["should contain only alphabets and numbers"],"email":["not a valid email"],"age":["should not be null"]}

  Book book = Book('Fantastic beasts', author, [author, author]);
  e = book.validate();
  print(e.toJson());
}
