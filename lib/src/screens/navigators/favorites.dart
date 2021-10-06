import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites/bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_in.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_up.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/favorites/favorites_page.dart';

import 'navigators.dart';

class FavoriteNavigatorRoutes {
  static const String root = "/";
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
                BlocProvider.of<UserBloc>(context)
                    .add(UserLoad(authState.user.firebaseId));

                return BlocBuilder<UserBloc, UserState>(
                  builder: (userCtx, userState) {
                    if (userState is UserLoadSuccess) {
                      return BlocProvider<FavoritesBloc>(
                        create: (context) => FavoritesBloc(
                          context.read<BusinessRepository>(),
                        )..getBusinessList(userState.user.id),
                        child:
                            FavoritesPage(globalNavigator, userState.user.id),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                return BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(
                    authenticationRepository:
                        context.read<AuthenticationRepository>(),
                    authenticationBloc: context.read<AuthenticationBloc>(),
                  ),
                  child: SignIn(),
                );
              }
            },
          ),
      SignUp.pathName: (ctx) {
        return BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
          ),
          child: SignUp(),
        );
      },
      SignIn.pathName: (ctx) {
        return BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
          ),
          child: SignIn(),
        );
      }
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
