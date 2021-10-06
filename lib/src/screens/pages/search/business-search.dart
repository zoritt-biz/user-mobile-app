import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business-list/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business-list/filtered-businesses/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

class BusinessSearch extends SearchDelegate<String> {
  final BuildContext buildContext;
  final Function setQuery;
  final Function clearFilter;
  FilteredBusinessListBloc _filteredBusinessListBloc;
  BusinessListBloc _businessListBloc;

  BusinessSearch({this.buildContext, this.setQuery, this.clearFilter}) {
    _businessListBloc = BusinessListBloc(
      buildContext.read<BusinessRepository>(),
    )..getBusinessList();

    _filteredBusinessListBloc = FilteredBusinessListBloc(
      businessListBloc: _businessListBloc,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          close(context, query);
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    buildContext.read<BusinessBloc>().searchBusinesses(query, 0, 50);
    close(context, query);
    super.showResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filteredBusinessListBloc.filter(query: query);

    return BlocProvider<FilteredBusinessListBloc>.value(
      value: _filteredBusinessListBloc,
      child: BlocBuilder<FilteredBusinessListBloc, FilteredBusinessListState>(
        builder: (context, state) {
          if (state is FilteredBusinessListSuccessful) {
            if (state.businessList != null && state.businessList.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        state.businessList[index].autocompleteTerm,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        query = state.businessList[index].autocompleteTerm;
                        buildContext
                            .read<BusinessBloc>()
                            .searchBusinesses(query, 0, 100);
                        setQuery(query);
                        clearFilter();
                        close(context, query);
                      },
                    );
                  },
                  separatorBuilder: (context, _) {
                    return Divider(
                      thickness: 1,
                    );
                  },
                  itemCount: state.businessList.length,
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
