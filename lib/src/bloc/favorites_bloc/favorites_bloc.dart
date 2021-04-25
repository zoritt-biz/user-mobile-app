import 'package:bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites_bloc/favorites_state.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

class FavoritesBloc extends Cubit<FavoritesState> {
  final BusinessRepository businessRepository;

  FavoritesBloc(this.businessRepository) : super(FavoritesUnknown());

  void getBusinessList(String id) async {
    emit(FavoritesLoading());
    try {
      List<Business> business = await businessRepository.getFavoritesList(id);
      emit(FavoritesLoadSuccessful(business: business));
    } catch (e) {
      emit(FavoritesFailure(e.toString()));
    }
  }
}
