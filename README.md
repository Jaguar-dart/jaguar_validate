# jaguar_validate

A configurable and extensible validation framework for Dart that supports validation of objects (nested), arrays 
and primitive types. Supports error code and parameter support for translation.

# Usage

```dart
class Author implements Validatable {
  String name;

  String email;

  int age;

  Author.make(this.name, this.email, this.age);

  ObjectErrors validate() {
    final errors = ObjectErrors();
    errors['name'] = validateField(
        name, [isNotNull(), isNotEmpty(), isAlphaNumeric(), hasMaxLength(10)]);
    errors['email'] =
        validateField(email, [isNotNull(), isNotEmpty(), isEmailAddress()]);
    errors['age'] = validateField(age, [isNotNull()]);
    return errors;
  }
}

void main() {
    Author author = Author.make('Mark', 'mark@books.com', null);
    final errors = author.validate();
    print(errors.toJson()); //=> {"age":["should not be null"]}
}
```

# Validation rules

A validation rule is a function that takes a value and returns a list of errors. An error could be:

+ a String message
+ an integer error code
+ or an `ValidationError` object 

## Defining custom validation rules

```dart
List (dynamic value) {
    if (value == null) return ['should not be null'];
    return null;
}
```

## Validation rule constructor

Validation rule constructor is a function that takes configuration parameters and returns the actual validator. 
For example, to implement a validator that uses `length` configuration to validate length of strings:

```dart
Validator<String> hasLength(int length, {err = _hasLengthErrFunc}) {
  return (String value) {
    if (value == null) return null;

    if (value.runes.length != length)
      return ['should be $length characters long'];
    return null;
  };
}
```

# Apply validation rules on a value using validateValue

`validateValue` function takes a value and a list of `ValidationRule`s to validate the value with. It returns a list of 
all the errors found. 

```dart
void main() {
  print(validateValue('hello', [isNotNull(), hasLength(5)])); // => null
  print(validateValue('hello world!', [isNotNull(), hasLength(5)]));  // => [must have length 5]
}
```

# Localization and translation using ValidationError

For simple cases, an error message or an error code is enough. `ValidationError` provides a way to send error code
and error parameters to the client. Client can then use localization to construct translated error message from
error code and error parameters.

```dart
enum MyErrorCodes { shouldHave5Chars }

void main() {
  print(validateValue('hello world', [
    hasLength(5,
        err: (expected, actual) => ValidationError(
            code: MyErrorCodes.shouldHave5Chars.index,
            params: {'expected': expected, 'actual': actual}))
  ]));
}
```

# ObjectErrors

Validation is typically performed on complex objects, nested objects and arrays. `ObjectErrors` provides a way to
record validation errors by paths/keys. Dot is used as separator for keys of nested objects and arrays.

```dart
class Author implements Validatable {
  String name;

  String email;

  int age;

  Author.make(this.name, this.email, this.age);
}

void main() {
  Author author = Author.make('Mark', 'mark@books.com', 25);

  final errors = ObjectErrors();
  errors['name'] = validateField(
      author.name, [isNotNull(), isNotEmpty(), isAlphaNumeric(), hasMaxLength(10)]);
  errors['email'] =
      validateField(author.email, [isNotNull(), isNotEmpty(), isEmailAddress()]);
  errors['age'] = validateField(author.age, [isNotNull()]);
 print(errors.toJson());
}
```

## Errors on the object itself

`@` pseudo key is used to store errors found on the object itself.

## Nested objects

Dot is used as separator for keys of nested objects.

```dart
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

  Book(this.name, this.author, this.authors);

  ObjectErrors validate() {
    final errors = ObjectErrors();
    errors['name'] =
        validateValue(name, [isNotNull(), isNotEmpty(), hasMaxLength(10)]);
    errors['author'] = author.validate();
    return errors;
  }
}
```

## Arrays

Dot is used as separator for keys of arrays.

```dart
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

  List<Author> authors;

  Book(this.name, this.author, this.authors);

  ObjectErrors validate() {
    final errors = ObjectErrors();
    errors['name'] =
        validateValue(name, [isNotNull(), isNotEmpty(), hasMaxLength(10)]);
    errors['authors.@'] = validateValue(authors, [isNotNull()]);
    if(authors != null) {
      for(int i = 0; i < authors.length; i++) {
        errors['authors.$i'] = authors[i].validate();
      }
    }
    return errors;
  }
}
```

# Validatable

`Validatable` abstract class defines `validate` method that inherited classes can use to construct validation of its
properties using `ObjectErrors` and `validateValue`.

```dart
class Author implements Validatable {
  String name;

  String email;

  int age;

  Author.make(this.name, this.email, this.age);

  ObjectErrors validate() {
    final errors = ObjectErrors();
    errors['name'] = validateField(
        name, [isNotNull(), isNotEmpty(), isAlphaNumeric(), hasMaxLength(10)]);
    errors['email'] =
        validateField(email, [isNotNull(), isNotEmpty(), isEmailAddress()]);
    errors['age'] = validateField(age, [isNotNull()]);
    return errors;
  }
}
```

# Built-in ValidationRules

jaguar_validate provides various commonly used built-in validation rules.

## Customizing error messages

All built-in validation rule constructors provide an `err` parameter to customize the error messages.