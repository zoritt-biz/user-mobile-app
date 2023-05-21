import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites/state.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/search-item/search-item.dart';

class FavoritesPage extends StatefulWidget {
  final BuildContext globalNavigator;

  const FavoritesPage(this.globalNavigator);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<void> load() async {
    context.read<FavoritesBloc>().getBusinessList();
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
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        widget.globalNavigator,
                        "/business_detail",
                        arguments: [
                          favoritesState.business[index].id,
                          favoritesState.business[index].categories[0].name,
                        ],
                      );
                    },
                    child: SearchItem(
                      business: favoritesState.business[index],
                      globalNavigator: widget.globalNavigator,
                    ),
                  ),
                );
              } else {
                return Center(child: Text("You haven't liked any business"));
              }
            } else if (favoritesState is FavoritesFailure) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Unable to connect, please "),
                    TextButton(
                      onPressed: () {
                        load();
                      },
                      child: Text("Retry!"),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
