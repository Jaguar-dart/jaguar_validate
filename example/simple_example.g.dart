// GENERATED CODE - DO NOT MODIFY BY HAND

part of jaguar_validate.example.simple;

// **************************************************************************
// Generator: ValidatorGenerator
// Target: class Author
// **************************************************************************

abstract class _Author implements Validatable {
  String get name;

  String get email;

  int get age;

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

// **************************************************************************
// Generator: ValidatorGenerator
// Target: class Book
// **************************************************************************

abstract class _Book implements Validatable {
  String get name;

  Author get author;

  String get abstract;

  int get pages;

  int get price;

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
