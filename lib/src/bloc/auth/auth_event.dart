part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final User user;
  final AuthenticationStatus status;

  const AuthenticationStatusChanged({this.status, this.user});

  @override
  List<Object> get props => [status, user];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
