import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/bloc/auth/auth_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc({
    @required AuthenticationRepository authenticationRepository,
    @required AuthenticationBloc authenticationBloc,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        _authenticationBloc = authenticationBloc,
        super(LoginUnknown());

  final AuthenticationRepository _authenticationRepository;
  final AuthenticationBloc _authenticationBloc;

  Future<void> logInWithCredentials({String email, String password}) async {
    emit(LoginLoading());
    try {
      _authenticationBloc.pauseSubscription();
      User newUser = await _authenticationRepository.logInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _authenticationBloc.resumeSubscription();
      emit(LoginSuccessful(user: newUser));
    } catch (e) {
      _authenticationBloc.resumeSubscription();

      emit(LoginFailure(e.toString()));
    }
  }
}
