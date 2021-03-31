part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  final String id;

  const UserLoad(this.id);

  @override
  List<Object> get props => [];
}

class UserCreate extends UserEvent {
  final User user;

  const UserCreate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User Created {User: $user}';
}

class UserUpdate extends UserEvent {
  final User user;

  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'User Updated {User: $user}';
}

class UserDelete extends UserEvent {
  final String id;

  const UserDelete(this.id);

  @override
  List<Object> get props => [];

  @override
  toString() => 'User Deleted {User: $id}';
}
