import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NavigationBloc extends Cubit<NavigationState> {
  NavigationBloc() : super(NavigationUnknown());

  void navigateToSearchDelegate() {
    emit(NavigatedToSearchDelegate());
    emit(NavigationSuccess());
  }

  void navigateToSearch() {
    emit(NavigatedToSearch());
    emit(NavigationSuccess());
  }
}

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigatedToSearchDelegate extends NavigationState {}

class NavigatedToSearch extends NavigationState {}

class NavigationSuccess extends NavigationState {}

class NavigationUnknown extends NavigationState {}
