import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
