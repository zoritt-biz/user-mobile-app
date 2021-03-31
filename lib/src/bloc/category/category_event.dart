part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class CategoryLoad extends CategoryEvent {
  const CategoryLoad();

  @override
  List<Object> get props => [];
}
