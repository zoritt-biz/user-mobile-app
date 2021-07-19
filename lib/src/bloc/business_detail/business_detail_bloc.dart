import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_detail/business_detail_state.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

class BusinessDetailBloc extends Cubit<BusinessDetailState> {
  final BusinessRepository businessRepository;

  BusinessDetailBloc({@required this.businessRepository})
      : assert(businessRepository != null),
        super(BusinessDetailLoading());

  Future<void> getBusinessDetail(String id) async {
    emit(BusinessDetailLoading());
    try {
      final item = await businessRepository.getBusinessDetail(id);
      emit(BusinessDetailLoadSuccess(item));
    } catch (e) {
      emit(BusinessDetailOperationFailure(e.toString()));
    }
  }

  Future<void> getBusinessesLoggedIn(String id, String userId) async {
    emit(BusinessDetailLoading());
    try {
      final item = await businessRepository.getBusinessesLoggedIn(id, userId);
      emit(BusinessDetailLoadSuccess(item));
    } catch (e) {
      emit(BusinessDetailOperationFailure(e.toString()));
    }
  }
}
