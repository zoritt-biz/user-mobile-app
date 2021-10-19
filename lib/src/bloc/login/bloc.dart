import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'state.dart';

class LoginBloc extends Cubit<LoginState> {
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

  LoginBloc({
    @required AuthenticationBloc authenticationBloc,
    @required UserRepository userRepository,
  })  : _authenticationBloc = authenticationBloc,
        _userRepository = userRepository,
        super(LoginUnknown());

  Future<void> logInWithCredentials({String email, String password}) async {
    emit(LoginLoading());
    try {
      User newUser = await _userRepository.authenticate(
        email: email,
        password: password,
      );
      _authenticationBloc.add(AuthenticationStatusChanged(user: newUser));
      emit(LoginSuccessful(user: newUser));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
