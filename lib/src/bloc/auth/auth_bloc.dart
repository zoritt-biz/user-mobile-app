import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
      (user) {
        add(AuthenticationStatusChanged(user: user));
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User> _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield* _mapAuthStatusChangedToState(event);
    }
    if (event is AuthenticationLogoutRequested) {
      await _authenticationRepository.logOut();

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
    yield event.user == null
        ? AuthenticationState.unauthenticated()
        : AuthenticationState.authenticated(event.user);
    // switch (event.status) {
    //   case AuthenticationStatus.unauthenticated:
    //     yield AuthenticationState.unauthenticated();
    //     break;
    //   case AuthenticationStatus.authenticated:
    //   // final user = await _tryGetUser();
    //   //   _authenticationRepository.persistToken(event.user);
    //     yield AuthenticationState.authenticated(event.user);
    //
    //     break;
    //   default:
    //
    //     // User user=await _authenticationRepository.getPersistedUser();
    //     // if(user!=null){
    //     //   yield AuthenticationState.authenticated(user);
    //     // }else{
    //       yield AuthenticationState.unknown();
    //
    //     // }
    //
    //
    // }
  }
}
