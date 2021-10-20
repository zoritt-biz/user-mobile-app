import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/menus.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/loading/loading.dart';

class MenuDisplay extends StatelessWidget {
  static const String pathName = "/menu_display";

  final List<String> names;
  final List<double> prices;

  MenuDisplay({this.names, this.prices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explore Our Menu')),
      body: BlocBuilder<BusinessDetailBloc, BusinessDetailState>(
        builder: (menuCtx, menuState) {
          if (menuState is BusinessMenusLoadSuccess) {
            return ListView.builder(
              itemCount: menuState.menu.length,
              itemBuilder: (context, index) => MenuItem(
                category: menuState.menu[index].category,
                menuList: menuState.menu[index].menuList,
              ),
            );
          } else if (menuState is BusinessMenusLoading) {
            return Loading();
          } else {
            return Center(
              child: Text("Unable to connect"),
            );
          }
        },
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String category;
  final List<MenuList> menuList;

  MenuItem({this.menuList, this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: menuList.length,
      itemBuilder: (context, index) => index == 0
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                category,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )
          : Card(
              color: Colors.grey[100],
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menuList[index].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${menuList[index].price} birr',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
