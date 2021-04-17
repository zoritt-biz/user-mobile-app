import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'sponsored_event.dart';
part 'sponsored_state.dart';

class SponsoredBloc extends Cubit<SponsoredState> {
  final BusinessRepository businessRepository;

  SponsoredBloc({@required this.businessRepository})
      : assert(businessRepository != null),
        super(SponsoredLoading());

  Future<void> getSponsored(int limit) async {
    emit(SponsoredLoading());
    try {
      List<Business> businesses = await businessRepository.getSponsoredBusinesses(limit);
      emit(SponsoredLoadSuccess(businesses));
    } catch (e) {
      emit(SponsoredOperationFailure(e.toString()));
    }
  }
}
