import 'package:equatable/equatable.dart';

abstract class PostLikeState extends Equatable {
  const PostLikeState();

  @override
  List<Object> get props => [];
}

class PostLiking extends PostLikeState {}

class PostLikingSuccessful extends PostLikeState {}

class PostLikingFailure extends PostLikeState {
  final String message;

  PostLikingFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PostUnliking extends PostLikeState {}

class PostUnlikingSuccessful extends PostLikeState {}

class PostUnlikingFailure extends PostLikeState {
  final String message;

  PostUnlikingFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PostLikeUnknown extends PostLikeState {}
