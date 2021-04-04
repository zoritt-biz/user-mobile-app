import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/business_detail/business_detail.dart';
import 'package:zoritt_mobile_app_user/src/screens/posts_page/StoriesBloc.dart';

import '../posts_page/posts_page.dart';
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
      case BusinessDetail.pathName:
        return MaterialPageRoute(builder: (_) => BusinessDetail());
      case PostsPage.pathName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<StoryBloc>(
            create: (context) => StoryBloc(),
            child: PostsPage(),
          ),
        );
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
