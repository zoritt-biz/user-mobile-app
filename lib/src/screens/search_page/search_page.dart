import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/NavigationBloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/navigation/navigators.dart';

class SearchPage extends StatelessWidget {
  final BuildContext globalNavigator;

  const SearchPage({Key key, this.globalNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
        listener: (context, state) {
          if (state is NavigatedToSearch) {
            showSearch(
                delegate: BusinessSearch(buildContext: context),
                context: context);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Search"),
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(
                        delegate: BusinessSearch(buildContext: context),
                        context: context);
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
              builder: (context, state) {
                if (state is BusinessLoadSuccess) {
                  if (state.business.isNotEmpty) {
                    return body(context, state.business);
                  }
                  return Center(
                    child: Text("No business found "),
                  );
                }
                return shimmer(context);
              },
              listener: (context, state) {
                if (state is BusinessUnknown) {
                  // showSearch(
                  //     delegate: BusinessSearch(buildContext: context),
                  //     context: context);
                }
              },
            )));
  }

  Widget body(BuildContext context, List<Business> businesses) {
    return ListView(
      children: [
        SearchFilter(),
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
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, SearchNavigatorRoutes.businessDetail,
                      arguments: businesses[index]);
                },
                child: SearchResult(
                  business: businesses[index],
                ));
          },
          itemCount: businesses.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        )),
        // GestureDetector(
        //   onTap: () {
        //     print("here");
        //     Navigator.pushNamed(globalNavigator, "/business_detail");
        //   },
        //   child: SearchResult(
        //     title: 'Wow Burger',
        //     address: 'Arat kilo, Addis Ababa',
        //     phoneNumber: '+251912365478',
        //     name: 'Burger, Shawarma',
        //     price: 3,
        //     imageLink:
        //     "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
        //   ),
        // ),
        // SearchResult(
        //   title: 'Wow Burger',
        //   address: 'Arat kilo, Addis Ababa',
        //   phoneNumber: '+251912365478',
        //   name: 'Burger, Shawarma',
        //   price: 2,
        //   imageLink:
        //   "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
        // )
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
                    border: Border.all(color: Colors.grey)),
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey)),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey)),
                width: 40,
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey)),
              ),
            ],
          ),
        ));
  }

  Widget searchResultShimmer() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  color: Colors.grey,
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
                            color: Colors.grey,
                            width: 70,
                            height: 25,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey,
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
                            color: Colors.grey,
                            height: 20,
                          ))
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
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

  // final String title;
  // final String address;
  // final String phoneNumber;
  // final double price;
  // final String name;
  // final String imageLink;
  // final bool relatedBusiness;

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
                  widget.business.logoPic,
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
                      // if (widget.business.relatedBusiness != true)
                      //   Row(
                      //     children: [
                      //       Text(
                      //         '\$${widget.price.toString()}',
                      //         style: TextStyle(fontSize: 15),
                      //       ),
                      //       SizedBox(
                      //         width: 15,
                      //       ),
                      //       Text(
                      //         widget.name,
                      //         style: TextStyle(fontSize: 15),
                      //       )
                      //     ],
                      //   ),
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

class SearchFilter extends StatefulWidget {
  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.sort_outlined,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Open Now',
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey)),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                Text(
                  'Price',
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'All Filters',
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class BusinessSearch extends SearchDelegate<String> {
  final BuildContext buildContext;
  FilteredBusinessListBloc _filteredBusinessListBloc;
  BusinessListBloc _businessListBloc;

  BusinessSearch({this.buildContext}) {
    _businessListBloc =
        BusinessListBloc(buildContext.read<BusinessRepository>())
          ..getBusinessList();
    _filteredBusinessListBloc =
        FilteredBusinessListBloc(businessListBloc: _businessListBloc);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
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
        });
  }

  @override
  void showResults(BuildContext context) {
    buildContext.read<BusinessBloc>().searchForBusinesses(query, 0, 100);
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
    // print(query);

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
