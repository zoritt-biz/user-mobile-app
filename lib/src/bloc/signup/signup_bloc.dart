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
    @required AuthenticationBloc authenticationBloc,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        _authenticationBloc = authenticationBloc,
        super(SignUpUnknown());

  final AuthenticationRepository _authenticationRepository;
  final AuthenticationBloc _authenticationBloc;

  Future<void> signUp({
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
  }) async {
    emit(SignUpLoading());
    try {
      _authenticationBloc.pauseSubscription();
      final newUser = await _authenticationRepository.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      );
      emit(SignUpSuccessful(user: newUser));
      _authenticationBloc.resumeSubscription();
    } catch (e) {
      _authenticationBloc.resumeSubscription();
      emit(SignUpFailure(e.toString()));
    }
  }
}
