import 'package:bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/businessList/business_list_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

class BusinessListBloc extends Cubit<BusinessListState> {
  final BusinessRepository businessRepository;

  BusinessListBloc(this.businessRepository) : super(BusinessListUnknown());

  void getBusinessList() async {
    emit(BusinessListLoading());
    try {
      List<BusinessList> businessList =
          await businessRepository.getBusinessList();
      emit(BusinessListLoadSuccessful(businessList: businessList));
    } catch (e) {
      emit(BusinessListFailure(e.toString()));
    }
  }
}
