import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';

class EventsBloc extends Cubit<EventsState> {
  final EventsRepository eventRepository;

  EventsBloc({@required this.eventRepository}) : super(EventsUnknown());

  Future<void> getEvents(int page, int perPage) async {
    emit(EventsLoading());
    try {
      List<Events> events = await eventRepository.getEvents(page, perPage);
      emit(EventsLoadSuccessful(events: events));
    } catch (e) {
      emit(EventsLoadFailure(e.toString()));
    }
  }
}
