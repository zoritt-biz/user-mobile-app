import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'signup_state.dart';

class SignUpBloc extends Cubit<SignUpState> {
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

  SignUpBloc({
    @required AuthenticationBloc authenticationBloc,
    @required UserRepository userRepository,
  })  : _authenticationBloc = authenticationBloc,
        _userRepository = userRepository,
        super(SignUpUnknown());

  Future<void> signUp({
    String email,
    String password,
    String firstName,
    String lastName,
    String middleName,
    String phoneNumber,
  }) async {
    emit(SignUpLoading());
    try {
      User newUser = await _userRepository.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        phoneNumber: phoneNumber,
      );
      _authenticationBloc.add(AuthenticationStatusChanged(user: newUser));
      emit(SignUpSuccessful(user: newUser));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
