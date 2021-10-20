import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/user/user_repository.dart';

class AuthenticationRepository {
  final UserRepository userRepository;

  AuthenticationRepository({@required this.userRepository});

  Stream<User> get user async* {
    var controller = StreamController<User>();
    String token = await userRepository.hasToken();
    if(token == null){
      yield* controller.stream;
    }
    User user = await userRepository.getUser();
    user.token = token;
    controller.add(user);
    controller.close();
    yield* controller.stream;
  }
}
