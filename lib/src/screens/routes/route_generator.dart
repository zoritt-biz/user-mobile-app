import 'package:flutter/material.dart';

import '../screens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case HomePage.pathName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case SignIn.pathName:
        return MaterialPageRoute(builder: (_) => SignIn());
      case SignUp.pathName:
        return MaterialPageRoute(builder: (_) => SignUp());
      case ResetPassword.pathName:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
