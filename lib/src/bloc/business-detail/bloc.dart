import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';
import 'package:zoritt_mobile_app_user/src/models/menus.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'state.dart';

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

  Future<void> getBusinessMenus(String id) async {
    emit(BusinessMenusLoading());
    try {
      final item = await businessRepository.getBusinessMenus(id);
      emit(BusinessMenusLoadSuccess(item));
    } catch (e) {
      emit(BusinessMenusOperationFailure(e.toString()));
    }
  }

  Future<void> getBusinessBranches(String id) async {
    emit(BusinessBranchesLoading());
    try {
      final item = await businessRepository.getBusinessBranches(id);
      emit(BusinessBranchesLoadSuccess(item));
    } catch (e) {
      emit(BusinessBranchesOperationFailure(e.toString()));
    }
  }
}
