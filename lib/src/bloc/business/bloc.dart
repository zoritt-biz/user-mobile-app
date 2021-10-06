import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'state.dart';

class BusinessBloc extends Cubit<BusinessState> {
  final BusinessRepository businessRepository;

  BusinessBloc({@required this.businessRepository})
      : assert(businessRepository != null),
        super(BusinessUnknown());

  void searchBusinesses(String query, int skip, int limit) async {
    emit(BusinessLoading());
    try {
      final item = await businessRepository.getBusinesses(query, skip, limit);
      emit(BusinessLoadSuccess(item));
    } catch (e) {
      emit(BusinessOperationFailure(e.toString()));
    }
  }

  void searchBusinessesByCategory(String query, int skip, int limit) async {
    emit(BusinessLoading());
    try {
      final item =
          await businessRepository.getBusinessesByCategory(query, skip, limit);
      emit(BusinessLoadSuccess(item));
    } catch (e) {
      emit(BusinessOperationFailure(e.toString()));
    }
  }

  void searchBusinessesByFilter({
    String query,
    int skip,
    int limit,
  }) async {
    emit(BusinessLoading());
    try {
      final item = await businessRepository.searchForBusinessesByFilter(
        query: query,
        limit: limit,
        skip: skip,
      );
      emit(BusinessLoadSuccess(item));
    } catch (e) {
      emit(BusinessOperationFailure(e.toString()));
    }
  }

  void searchBusinessesByFilterAndLocation({
    String query,
    int skip,
    int limit,
    double lat,
    double km,
    double lng,
  }) async {
    emit(BusinessLoading());
    try {
      final item =
          await businessRepository.searchForBusinessesByFilterAndLocation(
              query: query,
              limit: limit,
              skip: skip,
              lat: lat,
              lng: lng,
              km: km);
      item.sort((biz1, biz2) => biz1.distance.compareTo(biz2.distance));
      emit(BusinessLoadSuccess(item));
    } catch (e) {
      emit(BusinessOperationFailure(e.toString()));
    }
  }

  void searchBusinessesByLocation({
    String query,
    int skip,
    int limit,
    double km,
    double lat,
    double lng,
  }) async {
    emit(BusinessLoading());
    try {
      final item = await businessRepository.searchForBusinessesByLocation(
          query: query, limit: limit, skip: skip, lat: lat, lng: lng, km: km);
      emit(BusinessLoadSuccess(item));
    } catch (e) {
      emit(BusinessOperationFailure(e.toString()));
    }
  }
}
