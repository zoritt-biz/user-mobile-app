import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'favorites.dart';
export 'home.dart';
export 'profile.dart';
export 'search.dart';

abstract class TabNavigator extends StatelessWidget {}

typedef CustomWidgetBuilder = Widget Function(
  BuildContext context,
  RouteSettings routeSettings,
);
