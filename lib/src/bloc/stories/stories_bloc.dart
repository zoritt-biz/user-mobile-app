import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/bloc/stories/stories_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/post/posts_repository.dart';

class StoryBloc extends Cubit<StoryState> {
  final PostRepository postRepository;
  DateTime dateTime = DateTime.now().subtract(Duration(days: 3));

  StoryBloc({@required this.postRepository}) : super(StoryUnknown());

  void emitStoryFinished() {
    emit(StoryFinished());
  }

  void emitUnknown() {
    emit(StoryUnknown());
  }

  void getStories(int page, int perPage, String filterDate) async {
    emit(StoryLoading());
    try {
      List<Post> posts =
          await postRepository.getPosts(page, perPage, filterDate);
      emit(StoryLoadSuccessful(posts: posts));
    } catch (e) {
      emit(StoryLoadFailure(e.toString()));
    }
  }
}
