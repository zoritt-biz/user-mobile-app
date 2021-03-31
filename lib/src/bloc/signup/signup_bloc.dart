import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'signup_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  SignUpBloc({
    @required AuthenticationRepository authenticationRepository,
    AuthenticationBloc authenticationBloc,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(SignUpUnknown());

  final AuthenticationRepository _authenticationRepository;

  Future<void> signUp({
    String email,
    String password,
    String fullName,
    String phoneNumber,
  }) async {
    emit(SignUpLoading());
    try {
      final newUser = await _authenticationRepository.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );

      emit(SignUpSuccessful(user: newUser));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
