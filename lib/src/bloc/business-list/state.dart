part of "bloc.dart";

abstract class BusinessListState extends Equatable {
  const BusinessListState();

  @override
  List<Object> get props => [];
}

class BusinessListLoading extends BusinessListState {}

class BusinessListLoadSuccessful extends BusinessListState {
  final List<BusinessList> businessList;

  BusinessListLoadSuccessful({this.businessList});

  @override
  List<Object> get props => [businessList];
}

class BusinessListFailure extends BusinessListState {
  final String message;

  BusinessListFailure(this.message);

  @override
  List<Object> get props => [message];
}

class BusinessListUnknown extends BusinessListState {}
