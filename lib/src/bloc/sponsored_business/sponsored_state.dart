import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

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
