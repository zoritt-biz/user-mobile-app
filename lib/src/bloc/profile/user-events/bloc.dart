import 'package:bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

import 'state.dart';

class UserEventsBloc extends Cubit<UserEventsState> {
  final UserRepository userRepository;

  UserEventsBloc(this.userRepository) : super(UserEventsUnknown());

  void getUserEvents(String id) async {
    emit(UserEventsLoading());
    try {
      List<Events> events = await userRepository.getUserEvents(id);
      emit(UserEventsSuccessful(events: events));
    } catch (e) {
      emit(UserEventsFailure(e.toString()));
    }
  }
}
