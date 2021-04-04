part of 'business_bloc.dart';

class BusinessState extends Equatable {
  const BusinessState();

  @override
  List<Object> get props => [];
}

class BusinessLoading extends BusinessState {}

class BusinessLoadSuccess extends BusinessState {
  final Business business;

  BusinessLoadSuccess(this.business);

  @override
  List<Object> get props => [business];
}

class BusinessOperationFailure extends BusinessState {
  final String message;

  BusinessOperationFailure(this.message);
}
