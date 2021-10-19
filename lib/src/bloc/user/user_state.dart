import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserUpdating extends UserState {}

class UserLoadSuccess extends UserState {
  final User user;

  UserLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserOperationFailure extends UserState {
  final String message;

  UserOperationFailure(this.message);
}
