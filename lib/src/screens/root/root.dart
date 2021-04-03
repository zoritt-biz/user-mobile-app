import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/navigation/bottom_navigation.dart';
import 'package:zoritt_mobile_app_user/src/screens/navigation/navigators.dart';

import '../screens.dart';

class HomePage extends StatefulWidget {
  static const String pathName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.home;
  DateTime dateTime=DateTime.now().subtract(Duration(days: 3));


  final tabNavigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<TabNavigator> tabNavigators;
  BuildContext _globalNavigatorContext;

  @override
  void initState() {

    tabNavigators = [
      HomeNavigator(navigatorKey: tabNavigatorKeys[TabItem.home.index]),
      SearchNavigator(navigatorKey: tabNavigatorKeys[TabItem.search.index]),
      FavoritesNavigator(
          navigatorKey: tabNavigatorKeys[TabItem.favorites.index]),
      MessagesNavigator(navigatorKey: tabNavigatorKeys[TabItem.messages.index]),
      ProfileNavigator(navigatorKey: tabNavigatorKeys[TabItem.profile.index]),
    ];
    _globalNavigatorContext = context;
    super.initState();
  }

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    setCurrentIndex(TabItem item) {
      setState(() {
        _currentTab = item;
      });
    }

    final List<BottomNavigationData> bottomNavigationData = [
      BottomNavigationData(
          onPressed: () {
            setCurrentIndex(TabItem.home);
          },
          icon: Icons.home,
          color: _currentTab == TabItem.home
              ? Theme.of(context).primaryColor
              : Colors.grey[600]),
      BottomNavigationData(
          onPressed: () {
            setCurrentIndex(TabItem.search);
          },
          icon: Icons.search,
          color: _currentTab == TabItem.search
              ? Theme.of(context).primaryColor
              : Colors.grey[600]),
      BottomNavigationData(
          onPressed: () {
            setCurrentIndex(TabItem.favorites);
          },
          icon: Icons.favorite,
          color: _currentTab == TabItem.favorites
              ? Theme.of(context).primaryColor
              : Colors.grey[600]),
      BottomNavigationData(
          onPressed: () {
            setCurrentIndex(TabItem.messages);
          },
          icon: Icons.message,
          color: _currentTab == TabItem.messages
              ? Theme.of(context).primaryColor
              : Colors.grey[600]),
      BottomNavigationData(
          onPressed: () {
            setCurrentIndex(TabItem.profile);
          },
          icon: Icons.account_circle,
          color: _currentTab == TabItem.profile
              ? Theme.of(context).primaryColor
              : Colors.grey[600]),
    ];

    return WillPopScope(
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
        body: IndexedStack(
          index: _currentTab.index,
          children: [
            MultiBlocProvider(providers: [
              BlocProvider<EventsBloc>(
                  create: (context) => EventsBloc(
                        eventRepository: context.read<EventsRepository>()
                          ,
                      )..getEvents(10, "CREATEDAT_DESC")),
              BlocProvider<PostBloc>(
                  create: (context) => PostBloc(
                    postRepository: context.read<PostRepository>()
                    ,
                  )..getPosts(10, "CREATEDAT_DESC","${dateTime.month}/${dateTime.day}/${dateTime.year}",0)),

            ],
                child: _buildOffstageNavigator(TabItem.home),
            ),
            _buildOffstageNavigator(TabItem.search),
            _buildOffstageNavigator(TabItem.favorites),
            _buildOffstageNavigator(TabItem.messages),
            _buildOffstageNavigator(TabItem.profile),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
          bottomNavigationListData: bottomNavigationData,
          currentTab: _currentTab,
          colorScheme: colorScheme,
          textTheme: textTheme,
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem item) {
    return Visibility(
      visible: _currentTab == item,
      maintainState: true,
      child: tabNavigators[item.index],
    );
  }
}

enum TabItem { home, search, favorites, messages, profile }
