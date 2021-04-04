part of 'business_bloc.dart';

abstract class BusinessEvent extends Equatable {
  const BusinessEvent();
}

class BusinessLoad extends BusinessEvent {
  final String id;

  const BusinessLoad(this.id);

  @override
  List<Object> get props => [];
}
