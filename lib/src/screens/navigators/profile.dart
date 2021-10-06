import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile/bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_in.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_up.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/profile/profile_page.dart';

import 'navigators.dart';

class ProfileNavigatorRoutes {
  static const String root = "/";
}

class ProfileNavigator extends TabNavigator {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext globalNavigator;

  ProfileNavigator({this.navigatorKey, this.globalNavigator});

  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      ProfileNavigatorRoutes.root: (ctx) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (authCtx, authState) {
              if (authState.status == AuthenticationStatus.authenticated) {
                BlocProvider.of<UserBloc>(context)
                    .add(UserLoad(authState.user.firebaseId));

                return BlocBuilder<UserBloc, UserState>(
                  builder: (userCtx, userState) {
                    if (userState is UserLoadSuccess) {
                      return BlocProvider<ProfileBloc>(
                        create: (context) => ProfileBloc(
                          context.read<UserRepository>(),
                        )..getUserProfile(userState.user.firebaseId),
                        child: ProfilePage(
                          firebaseId: userState.user.firebaseId,
                          userId: userState.user.id,
                          globalNavigator: globalNavigator,
                        ),
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
      initialRoute: ProfileNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (ctx) => routeBuilders[routeSettings.name](ctx),
        );
      },
    );
  }
}
