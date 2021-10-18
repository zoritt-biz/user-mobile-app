import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'home.dart';
export 'search.dart';
// export 'favorites.dart';
// export 'profile.dart';

abstract class TabNavigator extends StatelessWidget {}

typedef CustomWidgetBuilder = Widget Function(
  BuildContext context,
  RouteSettings routeSettings,
);
