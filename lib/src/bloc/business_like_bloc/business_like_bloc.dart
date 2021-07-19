import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

import 'business_like_state.dart';

class BusinessLikeBloc extends Cubit<BusinessLikeState> {
  final BusinessRepository businessRepository;

  BusinessLikeBloc({@required this.businessRepository})
      : super(BusinessLikeUnknown());

  Future<void> likeBusiness(String userId, String businessId) async {
    emit(BusinessLiking());
    try {
      await businessRepository.likeBusiness(userId, businessId);
      emit(BusinessLikingSuccessful());
    } catch (e) {
      emit(BusinessLikingFailure(e.toString()));
    }
  }

  Future<void> unlikeBusiness(String userId, String businessId) async {
    emit(BusinessUnliking());
    try {
      await businessRepository.unlikeBusiness(userId, businessId);
      emit(BusinessUnlikingSuccessful());
    } catch (e) {
      emit(BusinessUnlikingFailure(e.toString()));
    }
  }
}
