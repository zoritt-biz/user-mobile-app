import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(LoginUnknown());

  final AuthenticationRepository _authenticationRepository;

  Future<void> logInWithCredentials({String email, String password}) async {
    emit(LoginLoading());
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccessful());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

// Future<void> logInWithGoogle() async {
//   emit(LoginLoading());
//   try {
//     await _authenticationRepository.logInWithGoogle();
//     emit(LoginSuccessful());
//   } catch (e) {
//     emit(LoginFailure(e.toString()));
//   }
// }

// Future<void> logInWithFaceBook()async{
//   emit(LoginLoading());
//   try {
//     await _authenticationRepository.logInWithFacebook();
//     emit(LoginSuccessful());
//   } catch(e) {
//     emit(LoginFailure(e.toString()));
//   }
// }
}
