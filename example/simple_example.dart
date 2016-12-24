// Copyright (c) 2016, teja. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_validate/jaguar_validate.dart';

class User {
  @HasLengthInRange(1, 10)
  String name;

  @IsEmail()
  String email;

  @HasLengthInRange(15, 75)
  String quote;
}
