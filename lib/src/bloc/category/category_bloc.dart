import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/category/category_repository.dart';

part 'category_state.dart';

class CategoryBloc extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({@required this.categoryRepository})
      : assert(categoryRepository != null),
        super(CategoryLoading());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      final item = await categoryRepository.getCategories();
      emit(CategoriesLoadSuccess(item));
    } catch (e) {
      emit(CategoryOperationFailure(e.toString()));
    }
  }
}
