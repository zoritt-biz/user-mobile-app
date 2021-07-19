import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoadSuccessful extends HomeState {
  final List<String> images;

  HomeLoadSuccessful({this.images});

  @override
  List<Object> get props => [images];
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}

class HomeUnknown extends HomeState {}
