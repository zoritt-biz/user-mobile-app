import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';

import 'state.dart';

class EventsLikeBloc extends Cubit<EventsLikeState> {
  final EventsRepository eventRepository;

  EventsLikeBloc({@required this.eventRepository}) : super(EventsLikeUnknown());

  Future<void> likeEvent(String userId, String eventId) async {
    emit(EventsLiking());
    try {
      await eventRepository.likeEvent(userId, eventId);
      emit(EventsLikingSuccessful());
    } catch (e) {
      emit(EventsLikingFailure(e.toString()));
    }
  }

  Future<void> unlikeEvent(String userId, String eventId) async {
    emit(EventsUnliking());
    try {
      await eventRepository.unlikeEvent(userId, eventId);
      emit(EventsUnlikingSuccessful());
    } catch (e) {
      emit(EventsUnlikingFailure(e.toString()));
    }
  }
}
