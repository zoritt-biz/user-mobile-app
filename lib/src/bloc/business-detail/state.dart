part of 'bloc.dart';

class BusinessDetailState extends Equatable {
  const BusinessDetailState();

  @override
  List<Object> get props => [];
}

class BusinessDetailLoading extends BusinessDetailState {}

class BusinessDetailLoadSuccess extends BusinessDetailState {
  final Business business;

  BusinessDetailLoadSuccess(this.business);

  @override
  List<Object> get props => [business];
}

class BusinessDetailOperationFailure extends BusinessDetailState {
  final String message;

  BusinessDetailOperationFailure(this.message);
}

class BusinessMenusLoading extends BusinessDetailState {}

class BusinessMenusLoadSuccess extends BusinessDetailState {
  final List<Menu> menu;

  BusinessMenusLoadSuccess(this.menu);

  @override
  List<Object> get props => [menu];
}

class BusinessMenusOperationFailure extends BusinessDetailState {
  final String message;

  BusinessMenusOperationFailure(this.message);
}

class BusinessBranchesLoading extends BusinessDetailState {}

class BusinessBranchesLoadSuccess extends BusinessDetailState {
  final List<Business> businesses;

  BusinessBranchesLoadSuccess(this.businesses);

  @override
  List<Object> get props => [businesses];
}

class BusinessBranchesOperationFailure extends BusinessDetailState {
  final String message;

  BusinessBranchesOperationFailure(this.message);
}
