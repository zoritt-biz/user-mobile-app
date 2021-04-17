






import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';



class NavigationBloc extends Cubit<NavigationState>{
  NavigationBloc() : super(NavigationUnknown());


  void navigateToSearch(){
    print("navigatedToSearch");
    emit(NavigatedToSearch());
    emit(NavigationUnknown());
  }

}

abstract class NavigationState extends Equatable{
@override
  // TODO: implement props
  List<Object> get props => [];
}
class NavigatedToSearch extends NavigationState{

}
class NavigationUnknown extends NavigationState{}
