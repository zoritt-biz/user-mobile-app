import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/repository/post/posts_repository.dart';

import 'post_like_state.dart';

class PostLikeBloc extends Cubit<PostLikeState> {
  final PostRepository postRepository;

  PostLikeBloc({@required this.postRepository}) : super(PostLikeUnknown());

  Future<void> likePost(String userId, String eventId) async {
    emit(PostLiking());
    try {
      await postRepository.likeEvent(userId, eventId);
      emit(PostLikingSuccessful());
    } catch (e) {
      emit(PostLikingFailure(e.toString()));
    }
  }

  Future<void> unlikePost(String userId, String eventId) async {
    emit(PostUnliking());
    try {
      await postRepository.unlikeEvent(userId, eventId);
      emit(PostUnlikingSuccessful());
    } catch (e) {
      emit(PostUnlikingFailure(e.toString()));
    }
  }
}
