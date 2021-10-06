import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/models/models.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/business-detail/branch.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/business-detail/location-page.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/menu/business_more_info.dart';
import 'package:zoritt_mobile_app_user/src/screens/components/menu/menu_info.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/reset.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_in.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_up.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/business-detail/business-detail.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/posts/posts_page.dart';

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
              authenticationBloc: context.read<AuthenticationBloc>(),
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
              authenticationBloc: context.read<AuthenticationBloc>(),
            ),
            child: SignUp(),
          ),
        );
      case ResetPassword.pathName:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case LocationPage.pathName:
        return MaterialPageRoute(builder: (_) => LocationPage(arguments[0]));
      case BusinessBranch.pathName:
        return MaterialPageRoute(builder: (_) => BusinessBranch(arguments[0]));
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
            ),
            child: BlocProvider<BusinessLikeBloc>(
                create: (ctx) => BusinessLikeBloc(
                      businessRepository: ctx.read<BusinessRepository>(),
                    ),
                child: BusinessDetail(id: arguments[0])),
          ),
        );
      case PostsPage.pathName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<StoryBloc>(
            create: (ctx) =>
                StoryBloc(postRepository: ctx.read<PostRepository>()),
            child: PostsPage(
              posts: arguments[0] as List<Post>,
              selectedPost: arguments[1] as int,
              globalNavigator: context,
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
