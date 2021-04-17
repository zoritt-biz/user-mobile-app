part of 'sponsored_bloc.dart';

abstract class SponsoredEvent extends Equatable {
  const SponsoredEvent();
}

class SponsoredLoad extends SponsoredEvent {
  const SponsoredLoad();

  @override
  List<Object> get props => [];
}
