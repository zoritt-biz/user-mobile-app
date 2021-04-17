part of 'sponsored_bloc.dart';

class SponsoredState extends Equatable {
  const SponsoredState();

  @override
  List<Object> get props => [];
}

class SponsoredLoading extends SponsoredState {}

class SponsoredLoadSuccess extends SponsoredState {
  final List<Business> sponsored;

  SponsoredLoadSuccess(this.sponsored);

  @override
  List<Object> get props => [sponsored];
}

class SponsoredOperationFailure extends SponsoredState {
  final String message;

  SponsoredOperationFailure(this.message);
}
