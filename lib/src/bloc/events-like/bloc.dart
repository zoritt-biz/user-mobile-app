import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';

import 'state.dart';

class EventsLikeBloc extends Cubit<EventsLikeState> {
  final EventsRepository eventRepository;

  EventsLikeBloc({@required this.eventRepository}) : super(EventsLikeUnknown());

  Future<void> likeEvent(String eventId) async {
    emit(EventsLiking());
    try {
      eventRepository.likeEvent(eventId);
      emit(EventsLikingSuccessful());
    } catch (e) {
      emit(EventsLikingFailure(e.toString()));
    }
  }

  Future<void> unlikeEvent(String eventId) async {
    emit(EventsUnliking());
    try {
      eventRepository.unlikeEvent(eventId);
      emit(EventsUnlikingSuccessful());
    } catch (e) {
      emit(EventsUnlikingFailure(e.toString()));
    }
  }
}
