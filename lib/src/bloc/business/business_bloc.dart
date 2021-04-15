
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

// part 'business_event.dart';
part 'business_state.dart';

class BusinessBloc extends Cubit<BusinessState> {
  final BusinessRepository businessRepository;

  BusinessBloc({@required this.businessRepository})
      : assert(businessRepository != null),
        super(BusinessUnknown());


  void searchForBusinesses(String query,int skip,int limit)async{
    print("businessloading");
    emit(BusinessLoading());
    try{
      print("gettingBusinesses");
      final item=await businessRepository.getBusinesses(query, skip, limit);
      emit(BusinessLoadSuccess(item));
    }catch (e){
      print("failed"+e.toString());
      emit(BusinessOperationFailure(e.toString()));
    }
  }


}
