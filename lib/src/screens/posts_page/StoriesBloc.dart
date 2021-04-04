

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/post/posts_repository.dart';

class StoryBloc extends Cubit<StoryState>{
  final PostRepository postRepository;
  DateTime dateTime=DateTime.now().subtract(Duration(days: 3));
  StoryBloc({@required this.postRepository}) : super(StoryUnknown());

  void emitStoryFinished(){
    emit(StoryFinished());
  }
  void emitUnknown(){
    emit(StoryUnknown());
  }
  void getStories(int skip,int limit,String sort)async{
    print("storyloading");
    emit(StoryLoading());
    try{
      List<Post>posts=await postRepository.getPosts(limit, sort,"${dateTime.month}/${dateTime.day}/${dateTime.year}",skip);
      print("storysuccessful");

      emit(StoryLoadSuccessful(posts: posts));
    }catch(e){
      print(e);
      print("storyfailed");
      // emit(StoryF)
    }

  }

}
abstract class StoryState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class StoryFinished extends StoryState{}
class StoryUnknown extends StoryState{}
class StoryLoadSuccessful extends StoryState{
  final List<Post> posts;
  StoryLoadSuccessful({this.posts});

  @override
  // TODO: implement props
  List<Object> get props => [posts];
}
class StoryLoading extends StoryState{}
