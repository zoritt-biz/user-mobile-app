import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

abstract class UserEventsState extends Equatable {
  const UserEventsState();

  @override
  List<Object> get props => [];
}

class UserEventsLoading extends UserEventsState {}

class UserEventsSuccessful extends UserEventsState {
  final List<Events> events;

  UserEventsSuccessful({this.events});

  @override
  List<Object> get props => [events];
}

class UserEventsFailure extends UserEventsState {
  final String message;

  UserEventsFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserEventsUnknown extends UserEventsState {}
