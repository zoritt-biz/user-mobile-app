import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

part 'state.dart';

class BusinessLikeBloc extends Cubit<BusinessLikeState> {
  final BusinessRepository businessRepository;

  BusinessLikeBloc({@required this.businessRepository})
      : super(BusinessLikeUnknown());

  Future<void> likeBusiness(String businessId) async {
    emit(BusinessLiking());
    try {
      businessRepository.likeBusiness(businessId);
      emit(BusinessLikingSuccessful());
    } catch (e) {
      emit(BusinessLikingFailure(e.toString()));
    }
  }

  Future<void> unlikeBusiness(String businessId) async {
    emit(BusinessUnliking());
    try {
      businessRepository.unlikeBusiness(businessId);
      emit(BusinessUnlikingSuccessful());
    } catch (e) {
      emit(BusinessUnlikingFailure(e.toString()));
    }
  }
}
