import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/pop-up/state.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

class PopUpBloc extends Cubit<PopUpState> {
  final BusinessRepository businessRepository;

  PopUpBloc({@required this.businessRepository})
      : assert(businessRepository != null),
        super(PopUpLoading());

  Future<void> getPopUp(String category) async {
    emit(PopUpLoading());
    try {
      final item = await businessRepository.getPopUp(category: category);
      emit(PopUpLoadSuccess(item));
    } catch (e) {
      emit(PopUpOperationFailure(e.toString()));
    }
  }
}
