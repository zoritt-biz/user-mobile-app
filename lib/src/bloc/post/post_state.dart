
import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostLoadSuccessful extends PostState {
  final List<Post> posts;

  PostLoadSuccessful({this.posts});

  @override
  List<Object> get props => [posts];
}

class PostLoadFailure extends PostState {
  final String message;
  PostLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PostUnknown extends PostState {}