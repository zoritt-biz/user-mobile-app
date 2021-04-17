import 'package:equatable/equatable.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

abstract class FilteredBusinessListState extends Equatable {
  const FilteredBusinessListState();

  @override
  List<Object> get props => [];
}

class FilteredBusinessListLoading extends FilteredBusinessListState {}

class FilteredBusinessListSuccessful extends FilteredBusinessListState {
  final List<BusinessList> businessList;
  final String query;

  FilteredBusinessListSuccessful({this.businessList, this.query});

  @override
  List<Object> get props => [businessList];
}
