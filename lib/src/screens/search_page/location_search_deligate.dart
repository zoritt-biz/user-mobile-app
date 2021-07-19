import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/location/location_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/location/location_state.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';

class LocationSearch extends SearchDelegate<String> {
  final BuildContext buildContext;
  final Function setQuery;
  LocationBloc _locationBloc;

  LocationSearch({this.buildContext, this.setQuery}) {
    _locationBloc = LocationBloc(
      buildContext.read<BusinessRepository>(),
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
    close(context, query);
    super.showResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != null && query != "")
      context.read<LocationBloc>().getLocation(query);
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (locationCtx, locationState) {
        if (locationState is LocationLoadSuccessful) {
          return Padding(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      locationState.location[index].description,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      query = locationState.location[index].description;
                      context.read<LocationBloc>()
                        ..getGeocode(locationState.location[index].placeId);
                      setQuery(query);
                      close(context, query);
                    },
                  );
                },
                separatorBuilder: (context, _) {
                  return Divider(
                    thickness: 1,
                  );
                },
                itemCount: locationState.location.length),
            padding: EdgeInsets.symmetric(horizontal: 20),
          );
        }
        return Container();
      },
    );
  }
}
