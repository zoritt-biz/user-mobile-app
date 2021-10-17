import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/category/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/location/bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/business/business_repository.dart';
import 'package:zoritt_mobile_app_user/src/repository/category/category_repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/categories/categories-page.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/categories/sub-category.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/search/search-page.dart';

import 'navigators.dart';

class SearchNavigatorRoutes {
  static const String root = "/";
  static const String categories = "/categories";
  static const String subcategories = "/subcategories";
}

class SearchNavigator extends TabNavigator {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext globalNavigator;

  SearchNavigator({this.navigatorKey, this.globalNavigator});

  Map<String, CustomWidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      SearchNavigatorRoutes.root: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LocationBloc>(
              create: (context) => LocationBloc(
                context.read<BusinessRepository>(),
              ),
            ),
          ],
          child: SearchPage(
            globalNavigator: globalNavigator,
            localBuildContext: navigatorKey.currentContext,
          ),
        );
      },
      HomeNavigatorRoutes.categories: (ctx, _) => BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
              categoryRepository: context.read<CategoryRepository>(),
            )..getCategories(),
            child: CategoriesPage(),
          ),
      HomeNavigatorRoutes.subcategories: (ctx, setting) {
        List<dynamic> arguments = setting.arguments as List;
        return Subcategory(arguments[0]);
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: SearchNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (ctx) => routeBuilders[routeSettings.name](
            ctx,
            routeSettings,
          ),
        );
      },
    );
  }
}
