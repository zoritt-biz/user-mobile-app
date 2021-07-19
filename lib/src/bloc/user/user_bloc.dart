import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({@required this.userRepository})
      : assert(UserRepository != null),
        super(UserLoading());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoad) {
      yield UserLoading();
      try {
        final item = await userRepository.getUser(event.id);
        yield UserLoadSuccess(item);
      } catch (e) {
        yield UserOperationFailure(e.toString());
      }
    }

    if (event is UserCreate) {
      yield UserCreating();
      try {
        final user = await userRepository.userCreate(event.user);
        yield UserLoadSuccess(user);
      } catch (e) {
        yield UserOperationFailure(e.toString());
      }
    }
  }
}
