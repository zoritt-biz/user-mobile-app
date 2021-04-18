import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';

abstract class StoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class StoryFinished extends StoryState {}

class StoryUnknown extends StoryState {}

class StoryLoadSuccessful extends StoryState {
  final List<Post> posts;

  StoryLoadSuccessful({this.posts});

  @override
  List<Object> get props => [posts];
}

class StoryLoadFailure extends StoryState {
  final String message;

  StoryLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class StoryLoading extends StoryState {}
