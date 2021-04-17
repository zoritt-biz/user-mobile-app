part of 'signup_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {}

class SignUpSuccessful extends SignUpState {
  final User user;

  SignUpSuccessful({this.user});

  @override
  List<Object> get props => [user];
}

class SignUpFailure extends SignUpState {
  final String message;

  SignUpFailure(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpUnknown extends SignUpState {}
