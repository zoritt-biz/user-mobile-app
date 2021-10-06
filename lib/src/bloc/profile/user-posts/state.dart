import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

abstract class UserPostsState extends Equatable {
  const UserPostsState();

  @override
  List<Object> get props => [];
}

class UserPostsLoading extends UserPostsState {}

class UserPostsSuccessful extends UserPostsState {
  final List<Post> posts;

  UserPostsSuccessful({this.posts});

  @override
  List<Object> get props => [posts];
}

class UserPostsFailure extends UserPostsState {
  final String message;

  UserPostsFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserPostsUnknown extends UserPostsState {}
