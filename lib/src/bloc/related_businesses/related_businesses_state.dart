import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class RelatedBusinessesState extends Equatable {
  const RelatedBusinessesState();

  @override
  List<Object> get props => [];
}

class RelatedBusinessesLoading extends RelatedBusinessesState {}

class RelatedBusinessesLoadSuccess extends RelatedBusinessesState {
  final List<Business> businesses;

  RelatedBusinessesLoadSuccess(this.businesses);

  @override
  List<Object> get props => [businesses];
}

class RelatedBusinessesOperationFailure extends RelatedBusinessesState {
  final String message;

  RelatedBusinessesOperationFailure(this.message);
}
