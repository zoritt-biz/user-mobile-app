import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/user/user_state.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_in.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_up.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/favorites/favorites_page.dart';

import 'navigators.dart';

class FavoriteNavigatorRoutes {
  static const String root = "/";
  static const String signIn = "/sign_in";
  static const String signUp = "/sign_up";
}

class FavoritesNavigator extends TabNavigator {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext globalNavigator;

  FavoritesNavigator({this.navigatorKey, this.globalNavigator});

  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      FavoriteNavigatorRoutes.root: (ctx) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (authCtx, authState) {
              if (authState.status == AuthenticationStatus.authenticated) {
                context.read<UserBloc>().getUserProfile();
                return BlocBuilder<UserBloc, UserState>(
                  builder: (userCtx, userState) {
                    if (userState is UserLoadSuccess) {
                      return BlocProvider<FavoritesBloc>(
                        create: (context) => FavoritesBloc(
                          context.read<BusinessRepository>(),
                        )..getBusinessList(),
                        child: FavoritesPage(globalNavigator),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                return BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(
                    userRepository: context.read<UserRepository>(),
                    authenticationBloc: context.read<AuthenticationBloc>(),
                  ),
                  child: SignIn(),
                );
              }
            },
          ),
      FavoriteNavigatorRoutes.signIn: (ctx) => BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          userRepository: context.read<UserRepository>(),
          authenticationBloc: context.read<AuthenticationBloc>(),
        ),
        child: SignIn(),
      ),
      FavoriteNavigatorRoutes.signUp: (ctx) => BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(
          userRepository: context.read<UserRepository>(),
          authenticationBloc: context.read<AuthenticationBloc>(),
        ),
        child: SignUp(),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: FavoriteNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (ctx) => routeBuilders[routeSettings.name](ctx),
        );
      },
    );
  }
}
