import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zoritt_mobile_app_user/src/screens/screens.dart';

class BottomNavigation extends StatelessWidget {
  final List<BottomNavigationData> bottomNavigationListData;

  final TabItem currentTab;
  final colorScheme;
  final textTheme;

  const BottomNavigation({
    Key key,
    this.currentTab,
    this.colorScheme,
    this.textTheme,
    this.bottomNavigationListData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomNavigationList = bottomNavigationListData
        .map(
          (e) => IconButton(
            icon: Icon(e.icon),
            onPressed: e.onPressed ?? () {},
            color: e.color,
            iconSize: 30,
          ),
        )
        .toList();

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
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

  BottomNavigationData({@required this.icon, this.onPressed, this.color});
}
