import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/screens.dart';

class BottomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final Function setCurrentIndex;
  final Function touchCounterIncrease;
  final Function touchCounterToZero;
  final int touchCounter;
  final BuildContext globalNavigatorContext;

  const BottomNavigation({
    Key key,
    this.currentTab,
    this.setCurrentIndex,
    this.touchCounterIncrease,
    this.touchCounterToZero,
    this.touchCounter,
    this.globalNavigatorContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationData> bottomNavigationData = [
      BottomNavigationData(
        onPressed: () {
          setCurrentIndex(TabItem.home);
          touchCounterIncrease();
          if (touchCounter > 1) {
            Navigator.pushNamedAndRemoveUntil(
                globalNavigatorContext, "/", (route) => false);
            touchCounterToZero();
          }
        },
        icon: currentTab == TabItem.home ? Icons.home : Icons.home_outlined,
        color: currentTab == TabItem.home
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
        label: "Home",
      ),
      BottomNavigationData(
        onPressed: () {
          setCurrentIndex(TabItem.search);
          if (context.read<NavigationBloc>().state is NavigationUnknown) {
            context.read<NavigationBloc>().navigateToSearchDelegate("query");
          }
        },
        icon:
            currentTab == TabItem.search ? Icons.search : Icons.search_outlined,
        color: currentTab == TabItem.search
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
        label: "Search",
      ),
      // BottomNavigationData(
      //   onPressed: () {
      //     setCurrentIndex(TabItem.favorites);
      //   },
      //   icon: currentTab == TabItem.favorites
      //       ? Icons.favorite
      //       : Icons.favorite_border_rounded,
      //   color: currentTab == TabItem.favorites
      //       ? Theme.of(context).accentColor
      //       : Theme.of(context).primaryColor,
      //   label: "Favorites",
      // ),
      // BottomNavigationData(
      //   onPressed: () {
      //     setCurrentIndex(TabItem.profile);
      //   },
      //   icon: currentTab == TabItem.profile
      //       ? Icons.account_circle
      //       : Icons.account_circle_outlined,
      //   color: currentTab == TabItem.profile
      //       ? Theme.of(context).accentColor
      //       : Theme.of(context).primaryColor,
      //   label: "Profile",
      // ),
    ];

    final List<Widget> bottomNavigationList = bottomNavigationData
        .map(
          (e) => Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(e.icon),
                onPressed: e.onPressed ?? () {},
                color: e.color,
                iconSize: 25,
              ),
              Text(e.label, style: TextStyle(fontSize: 13, color: e.color))
            ],
          ),
        )
        .toList();

    return BottomAppBar(
      color: Colors.white,
      elevation: 5,
      shape: CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bottomNavigationList,
        ),
      ),
    );
  }
}

class BottomNavigationData {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final String label;

  BottomNavigationData({
    @required this.icon,
    this.onPressed,
    this.color,
    this.label,
  });
}
