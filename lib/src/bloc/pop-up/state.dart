import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';
import 'package:zoritt_mobile_app_user/src/models/pop-up.dart';

class PopUpState extends Equatable {
  const PopUpState();

  @override
  List<Object> get props => [];
}

class PopUpLoading extends PopUpState {}

class PopUpLoadSuccess extends PopUpState {
  final PopUp popUp;

  PopUpLoadSuccess(this.popUp);

  @override
  List<Object> get props => [popUp];
}

class PopUpOperationFailure extends PopUpState {
  final String message;

  PopUpOperationFailure(this.message);
}
