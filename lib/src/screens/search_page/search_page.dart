import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/navigation_bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';

import 'business_search.dart';
import 'search_filter.dart';

class SearchPage extends StatefulWidget {
  final BuildContext globalNavigator;

  const SearchPage({Key key, this.globalNavigator}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  bool openNow = false;
  bool nearby = false;
  double km = 5;

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  setQuery(String q) {
    setState(() {
      query = q;
    });
  }

  clearFilter() {
    openNow = false;
    nearby = false;
  }

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

  setFilterState() async {
    setState(() {
      openNow = !openNow;
    });
    locationPermission();
    if (openNow && nearby) {
      context.read<BusinessBloc>().searchForBusinessesByFilterAndLocation(
            query: query,
            skip: 0,
            limit: 100,
            km: km,
            lng: _locationData.longitude,
            lat: _locationData.latitude,
          );
    } else if (openNow) {
      context.read<BusinessBloc>().searchForBusinessesByFilter(
            query: query,
            skip: 0,
            limit: 100,
          );
    } else if (nearby) {
      context.read<BusinessBloc>().searchForBusinessesByLocation(
            query: query,
            skip: 0,
            limit: 100,
            km: km,
            lng: _locationData.longitude,
            lat: _locationData.latitude,
          );
    } else {
      context.read<BusinessBloc>().searchForBusinesses(query, 0, 100);
    }
  }

  openLocationDelegate() async {
    setState(() {
      nearby = !nearby;
    });
    locationPermission();
    if (openNow && nearby) {
      context.read<BusinessBloc>().searchForBusinessesByFilterAndLocation(
            query: query,
            skip: 0,
            limit: 100,
            km: km,
            lng: _locationData.longitude,
            lat: _locationData.latitude,
          );
    } else if (openNow) {
      context.read<BusinessBloc>().searchForBusinessesByFilter(
            query: query,
            skip: 0,
            limit: 100,
          );
    } else if (nearby) {
      context.read<BusinessBloc>().searchForBusinessesByLocation(
            query: query,
            skip: 0,
            limit: 100,
            km: km,
            lng: _locationData.longitude,
            lat: _locationData.latitude,
          );
    } else {
      context.read<BusinessBloc>().searchForBusinesses(query, 0, 100);
    }
    // showSearch(
    //   delegate: LocationSearch(buildContext: context, setQuery: setQuery),
    //   context: context,
    // );
  }

  nearByKmChange(double newKm) async {
    setState(() {
      km = newKm;
    });
    locationPermission();
    if (openNow && nearby) {
      context.read<BusinessBloc>().searchForBusinessesByFilterAndLocation(
            query: query,
            skip: 0,
            limit: 100,
            km: km,
            lng: _locationData.longitude,
            lat: _locationData.latitude,
          );
    } else if (openNow) {
      context.read<BusinessBloc>().searchForBusinessesByFilter(
            query: query,
            skip: 0,
            limit: 100,
          );
    } else if (nearby) {
      context.read<BusinessBloc>().searchForBusinessesByLocation(
            query: query,
            skip: 0,
            limit: 100,
            km: km,
            lng: _locationData.longitude,
            lat: _locationData.latitude,
          );
    } else {
      context.read<BusinessBloc>().searchForBusinesses(query, 0, 100);
    }
    // showSearch(
    //   delegate: LocationSearch(buildContext: context, setQuery: setQuery),
    //   context: context,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (navCtx, state) {
        if (state is NavigatedToSearchDelegate) {
          showSearch(
            delegate: BusinessSearch(
                buildContext: context,
                setQuery: setQuery,
                clearFilter: clearFilter),
            context: context,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  delegate: BusinessSearch(
                      buildContext: context,
                      setQuery: setQuery,
                      clearFilter: clearFilter),
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
              return shimmer(context);
            } else if (bizState is BusinessOperationFailure) {
              return Center(child: Text("Error happened!"));
            } else {
              return Center(
                  child: Text(
                      "Please press the search icon above to get started."));
            }
          },
          listener: (bizCtx, bizState) {
            if (bizState is BusinessUnknown) {
              showSearch(
                delegate: BusinessSearch(
                    buildContext: context,
                    setQuery: setQuery,
                    clearFilter: clearFilter),
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
    if(query != "" && query != null){
      var index;
      for (int i = 0; i < newBusinesses.length; i++){
        if (newBusinesses[i].businessName.toLowerCase() == query){
          index = i;
          break;
        }
      }
      if(index != null){
        Business temp = newBusinesses[index];
        newBusinesses.removeAt(index);
        newBusinesses.insert(0, temp);
      }
    }
    return ListView(
      children: [
        SearchFilter(
          openNow: openNow,
          setFilterState: setFilterState,
          query: query,
          nearby: nearby,
          openSearchDelegate: openLocationDelegate,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (nearby)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("${km.floor()} KM"),
          ),
        if (nearby)
          Slider(
            value: km,
            onChanged: (newKm) {
              nearByKmChange(newKm);
            },
            min: 5,
            max: 20,
            divisions: 5,
            label: "$km",
          ),
        if (newBusinesses.length > 0)
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Results',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
          ),
        if (newBusinesses.length > 0)
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    widget.globalNavigator,
                    "/business_detail",
                    arguments: [newBusinesses[index].id],
                  );
                },
                child: SearchResult(business: newBusinesses[index]),
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

  Widget shimmer(BuildContext context) {
    return ListView(
      children: [
        searchFilterShimmer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        searchResultShimmer(),
        searchResultShimmer()
      ],
    );
  }

  Widget searchFilterShimmer() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.sort_outlined,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey),
              ),
              width: 40,
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchResultShimmer() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[300],
                              ),
                              width: 70,
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          height: 20,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Expanded(child:
                      Padding(
                        padding: EdgeInsets.only(right: 50),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          height: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
  final Business business;
  final BuildContext globalNavigator;

  SearchResult({this.business, this.globalNavigator});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.white10,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 150,
              child: Center(
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.business.pictures[0],
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      child: Container(
                        color: Colors.white10,
                      ),
                      filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.business.pictures[0],
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.business.businessName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      if (widget.business.distance != null &&
                          widget.business.distance != 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${widget.business.distance.roundToDouble()}km",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.business.location,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.business.phoneNumber[0],
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
