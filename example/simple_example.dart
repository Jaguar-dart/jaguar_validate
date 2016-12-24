// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_validate/jaguar_validate.dart';

class User implements Validatable {
  User.make(this.name, this.email, this.quote, this.age);

  @HasLengthInRange(1, 10)
  String name;

  @IsEmail()
  String email;

  @HasLengthInRange(15, 75)
  String quote;

  @IsInRange(20, 30)
  int age;
}

main() async {
  try {
    User user = new User.make(
        'teja', 'tejainece@gmail.com', 'Jaguar cofounder', 27);
    await user.validate();
  } on ValidationErrors catch(e) {
    print(e);
  }
}
