import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/filter.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'state.dart';

class BusinessBloc extends Cubit<BusinessState> {
  final BusinessRepository businessRepository;

  BusinessBloc({@required this.businessRepository})
      : assert(businessRepository != null),
        super(BusinessUnknown());

  void filterBusinesses(Filter filter, int page, int perPage) async {
    emit(BusinessLoading());
    try {
      final item = await businessRepository.getBusinessesByFilter(
        filter: filter,
        page: page,
        perPage: perPage,
      );
      emit(BusinessLoadSuccess(item));
    } catch (e) {
      emit(BusinessOperationFailure(e.toString()));
    }
  }
}
