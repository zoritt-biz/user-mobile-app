import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/events/events_bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/posts_page/StoriesBloc.dart';

import '../screens.dart';

abstract class TabNavigator extends StatelessWidget {}

class HomeNavigatorRoutes {
  static const String root = "/";
  static const String categories = "/categories";
  static const String events = "/events";
  static const String posts = "/posts";
  static const String sponsored_posts = "/sponsored_posts";
}

class HomeNavigator extends TabNavigator {
  final GlobalKey<NavigatorState> navigatorKey;

  HomeNavigator({this.navigatorKey});

  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      HomeNavigatorRoutes.root: (ctx) => Home(),
      HomeNavigatorRoutes.categories: (ctx) => CategoriesPage(),
      HomeNavigatorRoutes.events: (ctx) => BlocProvider<EventsBloc>(create:(context)=>EventsBloc(eventRepository: context.read<EventsRepository>())..getEvents(10, "CREATEDAT_DESC"),child:EventsPage()),
      HomeNavigatorRoutes.posts: (ctx) => BlocProvider<StoryBloc>(create: (context)=>StoryBloc(), child:PostsPage()),
      HomeNavigatorRoutes.sponsored_posts: (ctx) => SponsoredPostsPage(),
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
          builder: (ctx) => routeBuilders[routeSettings.name](ctx),
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

  SearchNavigator({this.navigatorKey});

  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      SearchNavigatorRoutes.root: (ctx) => Container(
        child: Center(
          child: Text("Search"),
        ),
      ),
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
          builder: (ctx) => routeBuilders[routeSettings.name](ctx),
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

  FavoritesNavigator({this.navigatorKey});

  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      FavoriteNavigatorRoutes.root: (ctx) {
        if(ctx.read<AuthenticationBloc>().state.status==AuthenticationStatus.authenticated){
          return FavoritesPage();
        }else{

          return BlocProvider<LoginBloc>(create:(context)=> LoginBloc(authenticationRepository: context.read<AuthenticationRepository>()),child:SignIn());

        }



      },
      SignUp.pathName:(ctx){
        return BlocProvider<SignUpBloc>(create:(context)=> SignUpBloc(authenticationRepository: context.read<AuthenticationRepository>()),child:SignUp());

      },
      SignIn.pathName:(ctx){
        return BlocProvider<LoginBloc>(create:(context)=> LoginBloc(authenticationRepository: context.read<AuthenticationRepository>()),child:SignIn());
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

class MessageNavigatorRoutes {
  static const String root = "/";
}

class MessagesNavigator extends TabNavigator {
  final GlobalKey<NavigatorState> navigatorKey;

  MessagesNavigator({this.navigatorKey});

  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      MessageNavigatorRoutes.root: (ctx) => Container(
        child: Center(
          child: Text("Messages"),
        ),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilder(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: MessageNavigatorRoutes.root,
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

  ProfileNavigator({this.navigatorKey});

  Map<String, WidgetBuilder> _routeBuilder(BuildContext context) {
    return {
      ProfileNavigatorRoutes.root: (ctx) {
        if(ctx.read<AuthenticationBloc>().state.status==AuthenticationStatus.authenticated){
          return ProfilePage();
        }else{

          return BlocProvider<LoginBloc>(create:(context)=> LoginBloc(authenticationRepository: context.read<AuthenticationRepository>()),child:SignIn());

        }



      },
      SignUp.pathName:(ctx){
        return BlocProvider<SignUpBloc>(create:(context)=> SignUpBloc(authenticationRepository: context.read<AuthenticationRepository>()),child:SignUp());

      },
      SignIn.pathName:(ctx){
        return BlocProvider<LoginBloc>(create:(context)=> LoginBloc(authenticationRepository: context.read<AuthenticationRepository>()),child:SignIn());
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
