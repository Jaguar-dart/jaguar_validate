// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:jaguar_validate/jaguar_validate.dart';

class Author implements Validatable {
  @HasLengthInRange(1, 10)
  String name;

  @IsEmail()
  String email;

  @HasLengthInRange(15, 75)
  String quote;

  @IsInRange(20, 30)
  int age;

  Future<Null> validate() async {
    ObjectValidationErrors ret = new ObjectValidationErrors(null);
    ret
        .mergePErr(await new HasLengthInRange(1, 10).validate('name', name))
        .mergePErr(await new IsEmail().validate('email', email))
        .mergePErr(await new HasLengthInRange(15, 75).validate('quote', quote))
        .mergePErr(await new IsInRange(20, 30).validate('age', age));

    if (ret.hasErrors) {
      throw ret;
    }
  }
}

class Book implements Validatable {
  Book.make(this.name, this.author);

  @HasLengthInRange(1, 10)
  String name;

  @ValidateValidatable()
  Author author;

  @HasLengthInRange(15, 75)
  String abstract;

  @IsGreaterThan(0)
  int pages;

  @IsInRange(1, 200)
  int price;

  Future<Null> validate() async {
    ObjectValidationErrors ret = new ObjectValidationErrors(null);

    ret.mergePErr(await new HasLengthInRange(1, 10).validate('name', name));
    ret.addOErr(await new ValidateValidatable().validate('author', author));
    ret.mergePErr(
        await new HasLengthInRange(15, 75).validate('abstract', abstract));
    ret.mergePErr(await new IsGreaterThan(0).validate('pages', pages));
    ret.mergePErr(await new IsInRange(1, 200).validate('price', price));

    if (ret.hasErrors) {
      throw ret;
    }
  }
}

main() async {
  try {
    Book book = new Book.make('Fantastic beasts', null);
    await book.validate();
  } on ValidationErrors catch (e) {
    print(e);
  }
}
