# Changelog

## 2.0.1

+ `ObjectErrors.splitKey` static method to split key into segments
+ ObjectError methods now recursively split key into segments
+ `ObjectErrors.hasErrors` method to check if there are any errors
+ `ObjectErrors.clear` to clear all errors

### Breaking changes

+ `ObjectErrors.asMap` not returns null if there are no errors

## 2.0.0

+ Total rewrite
+ `validateValue` to validate individual field with validators
+ `ObjectErrors` for object and array validation
+ `ValidationError` to support client side translation of error messages

## 1.0.0

- Basic `String`, `int`, `double` and `num` validators
