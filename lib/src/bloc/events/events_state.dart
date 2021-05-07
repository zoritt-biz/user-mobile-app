import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsLoading extends EventsState {}

class EventsLiking extends EventsState {}

class EventsLikingSuccessful extends EventsState {}

class EventsLikingFailure extends EventsState {
  final String message;

  EventsLikingFailure(this.message);

  @override
  List<Object> get props => [message];
}

class EventsLoadSuccessful extends EventsState {
  final List<Events> events;

  EventsLoadSuccessful({this.events});

  @override
  List<Object> get props => [events];
}

class EventsLoadFailure extends EventsState {
  final String message;

  EventsLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

class EventsUnknown extends EventsState {}
