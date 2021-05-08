import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';

class EventsBloc extends Cubit<EventsState> {
  final EventsRepository eventRepository;

  EventsBloc({@required this.eventRepository}) : super(EventsUnknown());

  Future<void> getEvents(int limit, String sort) async {
    emit(EventsLoading());
    try {
      List<Events> events = await eventRepository.getEvents(limit, sort);
      emit(EventsLoadSuccessful(events: events));
    } catch (e) {
      emit(EventsLoadFailure(e.toString()));
    }
  }

  Future<void> getEventsLoggedIn({
    int limit,
    String sort,
    String userId,
  }) async {
    emit(EventsLoading());
    try {
      List<Events> events = await eventRepository.getEventsLoggedIn(
          limit: limit, sort: sort, userId: userId);
      emit(EventsLoadSuccessful(events: events));
    } catch (e) {
      emit(EventsLoadFailure(e.toString()));
    }
  }
}
