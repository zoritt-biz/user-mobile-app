import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class NavigationBloc extends Cubit<NavigationState> {
  NavigationBloc() : super(NavigationUnknown());

  void navigateToSearchDelegate(String query) {
    emit(NavigatedToSearchDelegate());
    emit(NavigationSuccess(query));
  }

  void navigateToSearch(String query) {
    emit(NavigatedToSearch());
    emit(NavigationSuccess(query));
  }
}

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigatedToSearchDelegate extends NavigationState {}

class NavigatedToSearch extends NavigationState {}

class NavigationSuccess extends NavigationState {
  final String query;

  NavigationSuccess(this.query);

  @override
  List<Object> get props => [query];
}

class NavigationUnknown extends NavigationState {}
