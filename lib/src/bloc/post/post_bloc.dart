

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

import 'post_state.dart';

class PostBloc extends Cubit<PostState>{
  final PostRepository postRepository;
  PostBloc({@required this.postRepository}) : super(PostUnknown());

  Future<void> getPosts(int limit,String sort,String filterDate,int skip) async{
    print("loading");
    emit(PostLoading());
    try{

      List<Post> posts=await postRepository.getPosts(limit, sort,filterDate,skip);
      print("posts");
      emit(PostLoadSuccessful(posts: posts));
    }catch (e){
    print("failed");
    print(e);
      emit(PostLoadFailure(e.toString()));
    }
  }
  
}