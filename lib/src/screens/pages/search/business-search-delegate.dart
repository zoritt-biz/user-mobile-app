import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business-list/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business-list/filtered-businesses/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/filter.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

class BusinessSearchDelegate extends SearchDelegate<String> {
  final BuildContext buildContext;
  final Function setFilter;
  final Function setQuery;
  FilteredBusinessListBloc _filteredBusinessListBloc;
  BusinessListBloc _businessListBloc;

  BusinessSearchDelegate({
    this.buildContext,
    this.setFilter,
    this.setQuery,
  }) {
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
    buildContext.read<BusinessBloc>().filterBusinesses(
          new Filter(query: query),
          1,
          100,
        );
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
        builder: (filterCtx, state) {
          if (state is FilteredBusinessListSuccessful) {
            if (state.businessList != null && state.businessList.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text(
                        state.businessList[index].autocompleteTerm,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        query = state.businessList[index].autocompleteTerm;
                        setFilter(new Filter(query: query));
                        setQuery(query);
                        close(context, query);
                      },
                    );
                  },
                  separatorBuilder: (ctx, _) {
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
