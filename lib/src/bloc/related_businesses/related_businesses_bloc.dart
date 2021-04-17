import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/related_businesses/related_businesses_state.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

class RelatedBusinessesBloc extends Cubit<RelatedBusinessesState> {
  final BusinessRepository businessRepository;

  RelatedBusinessesBloc({@required this.businessRepository})
      : assert(businessRepository != null),
        super(RelatedBusinessesLoading());

  Future<void> getRelatedBusinesses(String category) async {
    emit(RelatedBusinessesLoading());
    try {
      final item = await businessRepository.getBusinesses(category, 0, 3);
      emit(RelatedBusinessesLoadSuccess(item));
    } catch (e) {
      emit(RelatedBusinessesOperationFailure(e.toString()));
    }
  }
}
