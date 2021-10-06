import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/home/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/post/bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/home/home_repository.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/categories/categories-page.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/categories/sub-category.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/events/events_page.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/home/home.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/sponsored-posts/sponsored_posts_page.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/what-is-new/what_is_new_page.dart';

import 'navigators.dart';

class HomeNavigatorRoutes {
  static const String root = "/";
  static const String categories = "/categories";
  static const String subcategories = "/subcategories";
  static const String events = "/events";
  static const String whatIsNew = "/what_is_new_page";
  static const String sponsored_posts = "/sponsored_posts";
}

class HomeNavigator extends TabNavigator {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext globalNavigator;

  HomeNavigator({this.navigatorKey, this.globalNavigator});

  DateTime dateTime = DateTime.now().subtract(Duration(days: 8));

  Map<String, CustomWidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      HomeNavigatorRoutes.root: (ctx, _) => Home(
            globalNavigator: globalNavigator,
          ),
      HomeNavigatorRoutes.categories: (ctx, _) => CategoriesPage(),
      HomeNavigatorRoutes.subcategories: (ctx, setting) {
        List<dynamic> arguments = setting.arguments as List;
        return Subcategory(arguments[0]);
      },
      HomeNavigatorRoutes.events: (ctx, _) =>
          EventsPage(globalNavigator: globalNavigator),
      HomeNavigatorRoutes.whatIsNew: (ctx, _) =>
          WhatIsNewPage(globalNavigator: globalNavigator),
      HomeNavigatorRoutes.sponsored_posts: (ctx, _) =>
          SponsoredPostsPage(globalNavigator: globalNavigator),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: HomeNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (ctx) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeBloc>(
                create: (context) =>
                    HomeBloc(context.read<HomeRepository>())..getImages(),
              ),
              BlocProvider<CategoryBloc>(
                create: (context) => CategoryBloc(
                  categoryRepository: context.read<CategoryRepository>(),
                )..getCategories(),
              ),
              BlocProvider<EventsBloc>(
                create: (context) => EventsBloc(
                  eventRepository: context.read<EventsRepository>(),
                )..getEvents(10, "CREATEDAT_DESC",
                    "${dateTime.year}/${dateTime.month}/${dateTime.day}"),
              ),
              BlocProvider<PostBloc>(
                create: (context) => PostBloc(
                  postRepository: context.read<PostRepository>(),
                )..getPosts(
                    10,
                    "CREATEDAT_DESC",
                    "${dateTime.year}/${dateTime.month}/${dateTime.day}",
                    0,
                  ),
              ),
              BlocProvider<SponsoredBloc>(
                create: (context) => SponsoredBloc(
                  businessRepository: context.read<BusinessRepository>(),
                )..getSponsored(5),
              ),
            ],
            child: routeBuilders[routeSettings.name](ctx, routeSettings),
          ),
        );
      },
    );
  }
}
