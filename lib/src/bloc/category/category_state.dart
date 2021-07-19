part of 'category_bloc.dart';

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoriesLoadSuccess extends CategoryState {
  final List<MainCategoryList> categories;

  CategoriesLoadSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryOperationFailure extends CategoryState {
  final String message;

  CategoryOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryUnknown extends CategoryState {}
