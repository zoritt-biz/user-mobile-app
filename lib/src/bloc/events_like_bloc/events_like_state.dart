import 'package:equatable/equatable.dart';

abstract class EventsLikeState extends Equatable {
  const EventsLikeState();

  @override
  List<Object> get props => [];
}

class EventsLiking extends EventsLikeState {}

class EventsLikingSuccessful extends EventsLikeState {}

class EventsLikingFailure extends EventsLikeState {
  final String message;

  EventsLikingFailure(this.message);

  @override
  List<Object> get props => [message];
}

class EventsUnliking extends EventsLikeState {}

class EventsUnlikingSuccessful extends EventsLikeState {}

class EventsUnlikingFailure extends EventsLikeState {
  final String message;

  EventsUnlikingFailure(this.message);

  @override
  List<Object> get props => [message];
}

class EventsLikeUnknown extends EventsLikeState {}
