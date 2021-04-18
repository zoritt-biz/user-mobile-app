import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/businessList/business_list_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/businessList/filtered_business_list_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/businessList/filtered_business_list_state.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business/business_bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

class BusinessSearch extends SearchDelegate<String> {
  final BuildContext buildContext;
  FilteredBusinessListBloc _filteredBusinessListBloc;
  BusinessListBloc _businessListBloc;

  BusinessSearch({this.buildContext}) {
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
    buildContext.read<BusinessBloc>().searchForBusinesses(query, 0, 50);
    close(context, query);
    super.showResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    // c.read<BusinessBloc>().searchForBusinesses(query, 0, 100);
    // close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filteredBusinessListBloc.filter(query: query);

    return BlocProvider<FilteredBusinessListBloc>.value(
      // create: (context){
      //   print(query);
      value: _filteredBusinessListBloc,
      //   return FilteredBusinessListBloc(businessListBloc: buildContext.read<BusinessListBloc>())..filter(query: query);

      child: BlocBuilder<FilteredBusinessListBloc, FilteredBusinessListState>(
        builder: (context, state) {
          if (state is FilteredBusinessListSuccessful) {
            if (state.businessList != null && state.businessList.isNotEmpty) {
              return Padding(
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
                              .searchForBusinesses(query, 0, 100);
                          close(context, query);
                        },
                      );
                    },
                    separatorBuilder: (context, _) {
                      return Divider(
                        thickness: 1,
                      );
                    },
                    itemCount: state.businessList.length),
                padding: EdgeInsets.symmetric(horizontal: 20),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}
