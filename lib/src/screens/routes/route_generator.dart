import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

import '../screens.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    List<dynamic> arguments = settings.arguments;

    switch (settings.name) {
      case HomePage.pathName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case SignIn.pathName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
            child: SignIn(),
          ),
        );
      case SignUp.pathName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SignUpBloc>(
            create: (context) => SignUpBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
            child: SignUp(),
          ),
        );
      case ResetPassword.pathName:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case MenuDisplay.pathName:
        return MaterialPageRoute(builder: (_) => MenuDisplay());
      case BusinessMoreInfo.pathName:
        return MaterialPageRoute(
            builder: (_) => BusinessMoreInfo(business: arguments[0]));
      case BusinessDetail.pathName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<BusinessDetailBloc>(
            create: (context) => BusinessDetailBloc(
              businessRepository: context.read<BusinessRepository>(),
            )..getBusinessDetail(arguments[0]),
            child: BusinessDetail(),
          ),
        );
      case PostsPage.pathName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<StoryBloc>(
            create: (context) =>
                StoryBloc(postRepository: context.read<PostRepository>()),
            child: PostsPage(
              posts: arguments[0] as List<Post>,
              selectedPost: arguments[1] as int,
            ),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
