import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

import 'state.dart';

class PostBloc extends Cubit<PostState> {
  final PostRepository postRepository;

  PostBloc({@required this.postRepository}) : super(PostUnknown());

  Future<void> getPosts(
    int limit,
    String sort,
    String filterDate,
    int skip,
  ) async {
    emit(PostLoading());
    try {
      List<Post> posts = await postRepository.getPosts(
        limit,
        sort,
        filterDate,
        skip,
      );
      emit(PostLoadSuccessful(posts: posts));
    } catch (e) {
      emit(PostLoadFailure(e.toString()));
    }
  }
}
