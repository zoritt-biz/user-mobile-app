import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/repository/post/posts_repository.dart';

import 'state.dart';

class PostLikeBloc extends Cubit<PostLikeState> {
  final PostRepository postRepository;

  PostLikeBloc({@required this.postRepository}) : super(PostLikeUnknown());

  Future<void> likePost(String postId) async {
    emit(PostLiking());
    try {
      postRepository.likePost(postId);
      emit(PostLikingSuccessful());
    } catch (e) {
      emit(PostLikingFailure(e.toString()));
    }
  }

  Future<void> unlikePost(String postId) async {
    emit(PostUnliking());
    try {
      postRepository.unlikePost(postId);
      emit(PostUnlikingSuccessful());
    } catch (e) {
      emit(PostUnlikingFailure(e.toString()));
    }
  }
}
