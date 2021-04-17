part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserCreating extends UserState {}

class UserUpdating extends UserState {}

class UserLoadSuccess extends UserState {
  final User user;

  UserLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserDeleteSuccess extends UserState {}

class UserOperationFailure extends UserState {
  final String message;

  UserOperationFailure(this.message);
}
