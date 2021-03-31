import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

part 'business_event.dart';

part 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  final BusinessRepository businessRepository;

  BusinessBloc({@required this.businessRepository})
      : assert(businessRepository != null),
        super(BusinessLoading());

  @override
  Stream<BusinessState> mapEventToState(BusinessEvent event) async* {
    if (event is BusinessLoad) {
      yield BusinessLoading();
      try {
        final item = await businessRepository.getBusiness(event.id);
        yield BusinessLoadSuccess(item);
      } catch (e) {
        yield BusinessOperationFailure(e.toString());
      }
    }

    if (event is BusinessCreate) {
      yield BusinessCreating();
      try {
        final business = await businessRepository.createBusiness(
            event.business, event.photo);
        yield BusinessLoadSuccess(business);
      } catch (e) {
        yield BusinessOperationFailure(e.toString());
      }
    }

    if (event is BusinessUpdate) {
      yield BusinessUpdating();
      try {
        Business item;
        if (event.field == "DESCRIPTION") {
          item = await businessRepository.updateDescription(
            event.business.id,
            event.business.description,
          );
        } else if (event.field == "SPECIALIZATION") {
          item = await businessRepository.updateSpecialization(
            event.business.id,
            event.business.specialization,
          );
        } else if (event.field == "HISTORY") {
          item = await businessRepository.updateHistory(
            event.business.id,
            event.business.history,
            event.business.establishedIn,
          );
        } else if (event.field == "ADDRESS_INFO") {
          item = await businessRepository.updateAddressInfo(
            event.business.id,
            event.business,
          );
        } else if (event.field == "CREATE_EVENT") {
          item = await businessRepository.createEvent(
            event.file,
            event.business,
            event.events,
          );
        } else if (event.field == "CREATE_POST") {
          item = await businessRepository.createPost(
            event.file,
            event.business,
            event.post,
          );
        }
        print(item);
        yield BusinessLoadSuccess(item);
      } catch (e) {
        yield BusinessOperationFailure(e.toString());
      }
    }

    if (event is BusinessDelete) {
      try {
        await businessRepository.deleteBusiness(event.id);
        yield BusinessDeleteSuccess();
      } catch (e) {
        yield BusinessOperationFailure(e.toString());
      }
    }
  }
}
