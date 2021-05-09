import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  setQuery(String q) {
    setState(() {
      query = q;
    });
  }

  setFilterState() {
    setState(() {
      openNow = !openNow;
    });
    if (openNow) {
      context.read<BusinessBloc>().searchForBusinessesByFilter(
            query: query,
            skip: 0,
            limit: 100,
          );
    } else {
      context.read<BusinessBloc>().searchForBusinesses(query, 0, 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (navCtx, state) {
        if (state is NavigatedToSearchDelegate) {
          showSearch(
            delegate: BusinessSearch(buildContext: context, setQuery: setQuery),
            context: context,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Search",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  delegate:
                      BusinessSearch(buildContext: context, setQuery: setQuery),
                  context: context,
                );
              },
              iconSize: 30,
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: BlocConsumer<BusinessBloc, BusinessState>(
          builder: (bizCtx, bizState) {
            if (bizState is BusinessLoadSuccess) {
              if (bizState.business.isNotEmpty) {
                return body(context, bizState.business);
              }
              return Center(child: Text("No business found "));
            } else if (bizState is BusinessLoading) {
              return shimmer(context);
            } else if (bizState is BusinessOperationFailure) {
              return Center(child: Text(bizState.message));
            } else {
              return Center(child: Text("Show Some thing"));
            }
          },
          listener: (bizCtx, bizState) {
            if (bizState is BusinessUnknown) {
              showSearch(
                delegate:
                    BusinessSearch(buildContext: context, setQuery: setQuery),
                context: context,
              );
            }
          },
        ),
      ),
    );
  }

  Widget body(BuildContext context, List<Business> businesses) {
    return ListView(
      children: [
        SearchFilter(openNow: openNow, setFilterState: setFilterState),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'All Result',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  widget.globalNavigator,
                  "/business_detail",
                  arguments: [businesses[index].id],
                );
              },
              child: SearchResult(business: businesses[index]),
            );
          },
          itemCount: businesses.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
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

  SearchResult({this.business});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  widget.business.pictures[0],
                  fit: BoxFit.fill,
                  height: 100,
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
                          Text(
                            widget.business.businessName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.orange,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
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
        ),
      ),
    );
  }
}
