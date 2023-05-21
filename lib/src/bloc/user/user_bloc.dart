import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/event.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';
import 'package:zoritt_mobile_app_user/src/repository/user/user_repository.dart';

import 'user_state.dart';

class UserBloc extends Cubit<UserState> {
  final UserRepository userRepository;

  UserBloc({@required this.userRepository})
      : assert(UserRepository != null),
        super(UserLoading());

  Future<void> getUserProfile() async {
    emit(UserLoading());
    try {
      final profile = await userRepository.getUser();
      emit(UserLoadSuccess(profile));
    } catch (e) {
      emit(UserOperationFailure(e.toString()));
    }
  }

  void getUserPosts() async {
    emit(UserPostsLoading());
    try {
      List<Post> posts = await userRepository.getUserPosts();
      emit(UserPostsSuccessful(posts: posts));
    } catch (e) {
      emit(UserPostsFailure(e.toString()));
    }
  }

  void getUserEvents() async {
    emit(UserEventsLoading());
    try {
      List<Events> events = await userRepository.getUserEvents();
      emit(UserEventsSuccessful(events: events));
    } catch (e) {
      emit(UserEventsFailure(e.toString()));
    }
  }
}
