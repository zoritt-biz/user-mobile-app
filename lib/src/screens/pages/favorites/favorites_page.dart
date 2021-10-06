import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites/state.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';

class FavoritesPage extends StatefulWidget {
  final BuildContext globalNavigator;
  final String id;

  const FavoritesPage(this.globalNavigator, this.id);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<void> load() async {
    context.read<FavoritesBloc>().getBusinessList(widget.id);
  }

  Future<void> _onRefresh() async {
    load();
    await Future.delayed(Duration(milliseconds: 3000), () {});
  }

  @override
  initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: 50.0,
      child: Scaffold(
        appBar: AppBar(title: Text("Favorites")),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (favoriteCtx, favoritesState) {
            if (favoritesState is FavoritesLoadSuccessful) {
              if (favoritesState.business.isNotEmpty) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  itemCount: favoritesState.business.length,
                  itemBuilder: (context, index) => FavoriteSearchResult(
                    business: favoritesState.business[index],
                    globalNavigator: widget.globalNavigator,
                  ),
                );
              } else {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You have note liked any business"),
                      TextButton(
                          onPressed: () {
                            load();
                          },
                          child: Text("Refresh!"))
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class FavoriteSearchResult extends StatefulWidget {
  final Business business;
  final BuildContext globalNavigator;

  FavoriteSearchResult({this.business, this.globalNavigator});

  @override
  _FavoriteSearchResultSearchResultState createState() =>
      _FavoriteSearchResultSearchResultState();
}

class _FavoriteSearchResultSearchResultState
    extends State<FavoriteSearchResult> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            widget.globalNavigator,
            "/business_detail",
            arguments: [widget.business.id],
          );
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                  widget.business.pictures[0],
                  fit: BoxFit.cover,
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
                      Text(
                        widget.business.businessName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
