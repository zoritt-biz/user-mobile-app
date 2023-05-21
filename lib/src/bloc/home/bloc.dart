import 'package:bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/home/state.dart';
import 'package:zoritt_mobile_app_user/src/repository/home/home_repository.dart';

class HomeBloc extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeUnknown());

  void getImages() async {
    emit(HomeLoading());
    try {
      List<String> images = await homeRepository.getImages();
      emit(HomeLoadSuccessful(images: images));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
