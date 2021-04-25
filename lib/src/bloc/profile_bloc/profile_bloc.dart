import 'package:bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/profile_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileBloc(this.userRepository) : super(ProfileUnknown());

  void getUserProfile(String id) async {
    emit(ProfileLoading());
    try {
      User user = await userRepository.getUserProfile(id);
      emit(ProfileLoadSuccessful(user: user));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
