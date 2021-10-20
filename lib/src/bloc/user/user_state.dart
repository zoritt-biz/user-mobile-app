import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/event.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';
import 'package:zoritt_mobile_app_user/src/models/user.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

//Profile

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

//Post

class UserPostsLoading extends UserState {}

class UserPostsSuccessful extends UserState {
  final List<Post> posts;

  UserPostsSuccessful({this.posts});

  @override
  List<Object> get props => [posts];
}

class UserPostsFailure extends UserState {
  final String message;

  UserPostsFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserPostsUnknown extends UserState {}

//Event

class UserEventsLoading extends UserState {}

class UserEventsSuccessful extends UserState {
  final List<Events> events;

  UserEventsSuccessful({this.events});

  @override
  List<Object> get props => [events];
}

class UserEventsFailure extends UserState {
  final String message;

  UserEventsFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserEventsUnknown extends UserState {}