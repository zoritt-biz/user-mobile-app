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
              Text(
                e.label,
                style: TextStyle(fontSize: 13, color: e.color),
              )
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

  BottomNavigationData(
      {@required this.icon, this.onPressed, this.color, this.label});
}
