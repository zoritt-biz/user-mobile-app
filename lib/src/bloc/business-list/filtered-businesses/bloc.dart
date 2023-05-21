import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/business-list.dart';

import '../bloc.dart';

part 'state.dart';

class FilteredBusinessListBloc extends Cubit<FilteredBusinessListState> {
  final BusinessListBloc businessListBloc;
  StreamSubscription _streamSubscription;

  FilteredBusinessListBloc({this.businessListBloc})
      : super(
          businessListBloc.state is BusinessListLoadSuccessful
              ? FilteredBusinessListSuccessful(
                  businessList:
                      (businessListBloc.state as BusinessListLoadSuccessful)
                          .businessList,
                )
              : FilteredBusinessListLoading(),
        ) {
    _streamSubscription = businessListBloc.listen((state) {
      if (state is BusinessListLoadSuccessful) {
        filter();
      }
    });
  }

  void filter({String query}) {
    print(query);
    if (!(businessListBloc.state is BusinessListLoadSuccessful)) {
      emit(FilteredBusinessListSuccessful(query: query));
    } else {
      if (state is FilteredBusinessListLoading) {
        emit(
          FilteredBusinessListSuccessful(
            businessList: (businessListBloc.state as BusinessListLoadSuccessful)
                .businessList,
          ),
        );
      } else {
        if (query == null) {
          String currentQuery = (state as FilteredBusinessListSuccessful).query;
          emit(
            FilteredBusinessListSuccessful(
              businessList:
                  (businessListBloc.state as BusinessListLoadSuccessful)
                      .businessList,
              query: currentQuery,
            ),
          );
        } else {
          final filteredList = filterList(
            query,
            (businessListBloc.state as BusinessListLoadSuccessful).businessList,
          );
          emit(
            FilteredBusinessListSuccessful(
                businessList: filteredList, query: query),
          );
        }
      }
    }
  }

  List<BusinessList> filterList(String query, List<BusinessList> businessList) {
    return businessList.where((element) {
      return element.autocompleteTerm
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
