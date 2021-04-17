import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

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
