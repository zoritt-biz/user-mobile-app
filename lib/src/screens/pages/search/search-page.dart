import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/filter.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/loading/shimmers.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/search-filter/search-filter.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/search-item/search-item.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/categories/category-list.dart';

import 'business-search-delegate.dart';

class SearchPage extends StatefulWidget {
  final BuildContext globalNavigator;

  const SearchPage({Key key, this.globalNavigator})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  String _chosenValue;

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  void initState() {
    locationPermission();
    super.initState();
  }

  void locationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
  }

  setFilter(Filter filter) async {
    locationPermission();
    context.read<BusinessBloc>().filterBusinesses(filter, 1, 100);
  }

  setQuery(String q) async {
    setState(() {
      query = q;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (navCtx, state) {
        if (state is NavigatedToSearchDelegate) {
          showSearch(
            delegate: BusinessSearchDelegate(
              buildContext: context,
              setFilter: setFilter,
            ),
            context: context,
          );
        }
        if (state is NavigationSuccess) {
          setQuery(state.query);
        }
        if (state is NavigatedToSearch) {
          setQuery(state.query);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  delegate: BusinessSearchDelegate(
                    buildContext: context,
                    setFilter: setFilter,
                    setQuery: setQuery,
                  ),
                  context: context,
                );
              },
              iconSize: 30,
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: BlocConsumer<BusinessBloc, BusinessState>(
          builder: (bizCtx, bizState) {
            if (bizState is BusinessLoadSuccess) {
              return body(context, bizState.business);
            } else if (bizState is BusinessLoading) {
              return SearchShimmer();
            } else if (bizState is BusinessOperationFailure) {
              return Center(child: Text("Error happened!"));
            } else {
              return Center(
                child: Text(
                  "Please press the search icon above to get started.",
                ),
              );
            }
          },
          listener: (bizCtx, bizState) {
            if (bizState is BusinessUnknown) {
              showSearch(
                delegate: BusinessSearchDelegate(
                  buildContext: context,
                  setFilter: setFilter,
                  setQuery: setQuery,
                ),
                context: context,
              );
            }
          },
        ),
      ),
    );
  }

  Widget body(BuildContext context, List<Business> businesses) {
    List<Business> newBusinesses = businesses.map((e) => e).toList();
    if (query != "" && query != null) {
      var index;
      for (int i = 0; i < newBusinesses.length; i++) {
        if (newBusinesses[i].businessName.toLowerCase() == query) {
          index = i;
          break;
        }
      }
      if (index != null) {
        Business temp = newBusinesses[index];
        newBusinesses.removeAt(index);
        newBusinesses.insert(0, temp);
      }
    }

    List<dynamic> icons = [...HOME_CATEGORY_LIST.map((e) => e["small_icon"])];

    List<String> categories = [...HOME_CATEGORY_LIST.map((e) => e["name"])];

    List<String> search = [...HOME_CATEGORY_LIST.map((e) => e["search"])];

    return ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: DropdownButton<String>(
                  focusColor: Colors.red,
                  value: _chosenValue,
                  elevation: 25,
                  style: TextStyle(color: Colors.yellow),
                  dropdownColor: Colors.grey[200],
                  iconSize: 30,
                  isDense: false,
                  underline: Container(),
                  icon: Container(),
                  iconEnabledColor: Colors.black,
                  items: categories.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: 300,
                          height: 60,
                          child: ListTile(
                            dense: true,
                            leading: Icon(icons[categories.indexOf(value)]),
                            title: Text(
                              value,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  hint: Row(
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down_rounded, size: 30)
                    ],
                  ),
                  onChanged: (String value) {
                    setQuery(search[categories.indexOf(value)]);
                    setFilter(
                      new Filter(category: [search[categories.indexOf(value)]]),
                    );
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.filter_list_rounded, size: 40),
                onPressed: () async {
                  await showDialog(
                    useSafeArea: true,
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.8),
                    barrierDismissible: true,
                    builder: (BuildContext context) => SearchFilterDialog(
                      setFilter: setFilter,
                      query: query,
                      locationData: _locationData,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(color: Colors.grey),
        ),
        SizedBox(height: 10),
        if (newBusinesses.length > 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Text(
                  "Results",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  query,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        SizedBox(height: 10),
        if (newBusinesses.length > 0)
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    widget.globalNavigator,
                    "/business_detail",
                    arguments: [
                      newBusinesses[index].id,
                      newBusinesses[index].categories[0].name,
                    ],
                  );
                },
                child: SearchItem(
                  business: newBusinesses[index],
                  globalNavigator: widget.globalNavigator,
                ),
              );
            },
            itemCount: newBusinesses.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        if (newBusinesses.length == 0) Center(child: Text("No results found!"))
      ],
    );
  }
}
