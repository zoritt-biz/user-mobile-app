import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoadSuccessful extends FavoritesState {
  final List<Business> business;

  FavoritesLoadSuccessful({this.business});

  @override
  List<Object> get props => [business];
}

class FavoritesFailure extends FavoritesState {
  final String message;

  FavoritesFailure(this.message);

  @override
  List<Object> get props => [message];
}

class FavoritesUnknown extends FavoritesState {}
