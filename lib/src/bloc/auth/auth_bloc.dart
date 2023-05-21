import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown, loading }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User> _userSubscription;

  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) {
        add(AuthenticationStatusChanged(user: user));
      },
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield* _mapAuthStatusChangedToState(event);
    }
    if (event is AuthenticationLogoutRequested) {
      await userRepository.deleteToken();
      yield AuthenticationState.unauthenticated();
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Stream<AuthenticationState> _mapAuthStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async* {
    if (event.user == null) {
      yield AuthenticationState.unauthenticated();
    } else {
      await userRepository.persistToken(event.user.token);
      yield AuthenticationState.authenticated(event.user);
    }
  }
}
