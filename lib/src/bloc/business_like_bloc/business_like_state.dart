import 'package:equatable/equatable.dart';

abstract class BusinessLikeState extends Equatable {
  const BusinessLikeState();

  @override
  List<Object> get props => [];
}

class BusinessLiking extends BusinessLikeState {}

class BusinessLikingSuccessful extends BusinessLikeState {}

class BusinessLikingFailure extends BusinessLikeState {
  final String message;

  BusinessLikingFailure(this.message);

  @override
  List<Object> get props => [message];
}

class BusinessUnliking extends BusinessLikeState {}

class BusinessUnlikingSuccessful extends BusinessLikeState {}

class BusinessUnlikingFailure extends BusinessLikeState {
  final String message;

  BusinessUnlikingFailure(this.message);

  @override
  List<Object> get props => [message];
}

class BusinessLikeUnknown extends BusinessLikeState {}
