import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/user/user_state.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_in.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/auth/sign_up.dart';
import 'package:zoritt_mobile_app_user/src/screens/pages/profile/profile_page.dart';

import 'navigators.dart';

class ProfileNavigatorRoutes {
  static const String root = "/";
  static const String signIn = "/sign_in";
  static const String signUp = "/sign_up";
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
                context.read<UserBloc>().getUserProfile();
                return BlocBuilder<UserBloc, UserState>(
                  builder: (userCtx, userState) {
                    if (userState is UserLoadSuccess) {
                      return BlocProvider<ProfileBloc>(
                        create: (context) => ProfileBloc(
                          context.read<UserRepository>(),
                        )..getUserProfile(),
                        child: ProfilePage(globalNavigator: globalNavigator),
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
      ProfileNavigatorRoutes.signIn: (ctx) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              userRepository: context.read<UserRepository>(),
              authenticationBloc: context.read<AuthenticationBloc>(),
            ),
            child: SignIn(),
          ),
      ProfileNavigatorRoutes.signUp: (ctx) => BlocProvider<SignUpBloc>(
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
      initialRoute: ProfileNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (ctx) => routeBuilders[routeSettings.name](ctx),
        );
      },
    );
  }
}
