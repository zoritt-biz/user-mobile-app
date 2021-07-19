import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/profile_bloc/profile_bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

import '../screens.dart';

abstract class TabNavigator extends StatelessWidget {}

typedef CustomWidgetBuilder = Widget Function(
    BuildContext context, RouteSettings routeSettings);

class HomeNavigatorRoutes {
  static const String root = "/";
  static const String categories = "/categories";
  static const String subcategories = "/subcategories";
  static const String events = "/events";
  static const String whatIsNew = "/what_is_new_page";
  static const String sponsored_posts = "/sponsored_posts";
}

class HomeNavigator extends TabNavigator {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext globalNavigator;

  HomeNavigator({this.navigatorKey, this.globalNavigator});

  DateTime dateTime = DateTime.now().subtract(Duration(days: 8));

  Map<String, CustomWidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      HomeNavigatorRoutes.root: (ctx, _) => Home(
            globalNavigator: globalNavigator,
          ),
      HomeNavigatorRoutes.categories: (ctx, _) => BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
              categoryRepository: context.read<CategoryRepository>(),
            )..getCategories(),
            child: CategoriesPage(),
          ),
      HomeNavigatorRoutes.subcategories: (ctx, setting) {
        List<dynamic> arguments = setting.arguments as List;
        return Subcategory(arguments[0]);
      },
      HomeNavigatorRoutes.events: (ctx, _) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (authBloc, authState) {
              if (authState.status == AuthenticationStatus.authenticated) {
                BlocProvider.of<UserBloc>(context)
                    .add(UserLoad(authState.user.firebaseId));

                return BlocBuilder<UserBloc, UserState>(
                  builder: (userCtx, userState) {
                    if (userState is UserLoadSuccess) {
                      return BlocProvider<EventsBloc>(
                        create: (context) => EventsBloc(
                          eventRepository: context.read<EventsRepository>(),
                        )..getEventsLoggedIn(
                            limit: 50, sort: "desc", userId: userState.user.id),
                        child: EventsPage(
                            globalNavigator: globalNavigator,
                            userId: userState.user.id),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              }
              return BlocProvider<EventsBloc>(
                create: (context) => EventsBloc(
                  eventRepository: context.read<EventsRepository>(),
                )..getEvents(10, "CREATEDAT_DESC",
                    "${dateTime.year}-${dateTime.month}-${dateTime.day}"),
                child: EventsPage(globalNavigator: globalNavigator),
              );
            },
          ),
      HomeNavigatorRoutes.whatIsNew: (ctx, _) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (authBloc, authState) {
              if (authState.status == AuthenticationStatus.authenticated) {
                BlocProvider.of<UserBloc>(context)
                    .add(UserLoad(authState.user.firebaseId));
                return BlocBuilder<UserBloc, UserState>(
                  builder: (userCtx, userState) {
                    if (userState is UserLoadSuccess) {
                      return BlocProvider<PostBloc>(
                        create: (postCtx) => PostBloc(
                          postRepository: context.read<PostRepository>(),
                        )..getPostLoggedIn(
                            limit: 100,
                            userId: userState.user.id,
                            sort: "CREATEDAT_DESC"),
                        child: WhatIsNewPage(
                          globalNavigator: globalNavigator,
                          userId: userState.user.id,
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else {
                return BlocProvider<PostBloc>(
                  create: (postCtx) => PostBloc(
                    postRepository: context.read<PostRepository>(),
                  )..getPosts(100, "CREATEDAT_DESC",
                      "${dateTime.year}/${dateTime.month}/${dateTime.day}", 0),
                  child: WhatIsNewPage(globalNavigator: globalNavigator),
                );
              }
            },
          ),
      HomeNavigatorRoutes.sponsored_posts: (ctx, _) =>
          BlocProvider<SponsoredBloc>(
            create: (context) => SponsoredBloc(
              businessRepository: context.read<BusinessRepository>(),
            )..getSponsored(10),
            child: SponsoredPostsPage(globalNavigator: globalNavigator),
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: HomeNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (ctx) =>
              routeBuilders[routeSettings.name](ctx, routeSettings),
        );
      },
    );
  }
}

class SearchNavigatorRoutes {
  static const String root = "/";
}

class SearchNavigator extends TabNavigator {
  final GlobalKey<NavigatorState> navigatorKey;
  final BuildContext globalNavigator;

  SearchNavigator({this.navigatorKey, this.globalNavigator});

  Map<String, CustomWidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      SearchNavigatorRoutes.root: (context, _) {
        return SearchPage(globalNavigator: globalNavigator);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: SearchNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (ctx) =>
              routeBuilders[routeSettings.name](ctx, routeSettings),
        );
      },
    );
  }
}

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
