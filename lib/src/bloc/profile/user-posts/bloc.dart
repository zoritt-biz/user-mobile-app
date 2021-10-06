import 'package:bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

import 'state.dart';

class UserPostsBloc extends Cubit<UserPostsState> {
  final UserRepository userRepository;

  UserPostsBloc(this.userRepository) : super(UserPostsUnknown());

  void getUserPosts(String id) async {
    emit(UserPostsLoading());
    try {
      List<Post> posts = await userRepository.getUserPosts(id);
      emit(UserPostsSuccessful(posts: posts));
    } catch (e) {
      emit(UserPostsFailure(e.toString()));
    }
  }
}
