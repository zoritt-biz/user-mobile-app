import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/bottom-navigation/bottom-navigation.dart';

import '../screens.dart';

class HomePage extends StatefulWidget {
  static const String pathName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.home;
  int touchCounter = 0;
  DateTime dateTime = DateTime.now().subtract(Duration(days: 8));

  final tabNavigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<TabNavigator> tabNavigators;
  BuildContext _globalNavigatorContext;

  @override
  void initState() {
    _globalNavigatorContext = context;
    tabNavigators = [
      HomeNavigator(
        navigatorKey: tabNavigatorKeys[TabItem.home.index],
        globalNavigator: _globalNavigatorContext,
      ),
      SearchNavigator(
        navigatorKey: tabNavigatorKeys[TabItem.search.index],
        globalNavigator: _globalNavigatorContext,
      ),
      FavoritesNavigator(
        navigatorKey: tabNavigatorKeys[TabItem.favorites.index],
        globalNavigator: _globalNavigatorContext,
      ),
      ProfileNavigator(
        navigatorKey: tabNavigatorKeys[TabItem.profile.index],
        globalNavigator: _globalNavigatorContext,
      ),
    ];
    super.initState();
  }

  touchCounterIncrease() {
    setState(() {
      touchCounter++;
    });
  }

  touchCounterToZero() {
    setState(() {
      touchCounter = 0;
    });
  }

  setCurrentIndex(TabItem item) {
    setState(() {
      _currentTab = item;
    });
  }

  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigatedToSearchDelegate || state is NavigatedToSearch) {
          setCurrentIndex(TabItem.search);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          final mayPop =
              await tabNavigatorKeys[_currentTab.index].currentState.maybePop();
          if (mayPop) {
            return false;
          } else if (!mayPop && _currentTab != TabItem.home) {
            setCurrentIndex(TabItem.home);
            return false;
          }
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.grey[100],
          body: IndexedStack(
            index: _currentTab.index,
            children: [
              _buildOffstageNavigator(TabItem.home, true),
              _buildOffstageNavigator(TabItem.search, true),
              _buildOffstageNavigator(TabItem.favorites, false),
              _buildOffstageNavigator(TabItem.profile, true),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            globalNavigatorContext: _globalNavigatorContext,
            setCurrentIndex: setCurrentIndex,
            touchCounterIncrease: touchCounterIncrease,
            touchCounter: touchCounter,
            touchCounterToZero: touchCounterToZero,
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem item, bool maintainState) {
    return Visibility(
      visible: _currentTab == item,
      maintainState: maintainState,
      child: tabNavigators[item.index],
    );
  }
}

enum TabItem { home, search, favorites, profile }
