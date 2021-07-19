import 'package:bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

import 'location_state.dart';

class LocationBloc extends Cubit<LocationState> {
  final BusinessRepository businessRepository;

  LocationBloc(this.businessRepository) : super(LocationUnknown());

  Future<void> getLocation(String query) async {
    emit(LocationLoading());
    try {
      final location = await businessRepository.getLocation(query);
      emit(LocationLoadSuccessful(location: location));
    } catch (e) {
      emit(LocationFailure(e.toString()));
    }
  }

  Future<void> getGeocode(String placeId) async {
    emit(LocationLoading());
    try {
      final latLng = await businessRepository.getGeocode(placeId);
      emit(GeocodeLoadSuccessful(latLng: latLng));
    } catch (e) {
      emit(LocationFailure(e.toString()));
    }
  }
}
