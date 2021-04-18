import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NavigationBloc extends Cubit<NavigationState> {
  NavigationBloc() : super(NavigationUnknown());

  void navigateToSearchDelegate() {
    emit(NavigatedToSearchDelegate());
    emit(NavigationUnknown());
  }

  void navigateToSearch() {
    emit(NavigatedToSearch());
    emit(NavigationUnknown());
  }
}

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigatedToSearchDelegate extends NavigationState {}

class NavigatedToSearch extends NavigationState {}

class NavigationUnknown extends NavigationState {}
