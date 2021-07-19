import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/home/home_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/location/location_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/navigation_bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';
import 'package:zoritt_mobile_app_user/src/repository/home/home_repository.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/screens.dart';

import 'client/client.dart';

class ZorittBusinessUser extends StatefulWidget {
  const ZorittBusinessUser({Key key}) : super(key: key);

  @override
  _ZorittBusinessUserState createState() => _ZorittBusinessUserState();
}

class _ZorittBusinessUserState extends State<ZorittBusinessUser> {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  final UserRepository userRepository = UserRepository(
    client: client(),
    firebaseStorage: FirebaseStorage.instance,
  );

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
    firebaseAuth: FirebaseAuth.instance,
    userRepository: UserRepository(
      client: client(),
      firebaseStorage: FirebaseStorage.instance,
    ),
  );

  final EventsRepository eventsRepository = EventsRepository(client: client());

  final HomeRepository homeRepository = HomeRepository(client: client());

  final PostRepository postRepository = PostRepository(client: client());

  final CategoryRepository categoryRepository = CategoryRepository(
    client: client(),
  );

  final BusinessRepository businessRepository = BusinessRepository(
    client: client(),
  );

  @override
  void initState() {
    locationPermission();
    super.initState();
  }

  void locationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: eventsRepository),
        RepositoryProvider.value(value: postRepository),
        RepositoryProvider.value(value: businessRepository),
        RepositoryProvider.value(value: userRepository),
        RepositoryProvider.value(value: homeRepository),
        RepositoryProvider.value(value: categoryRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
            lazy: false,
          ),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
            lazy: false,
          ),
          BlocProvider<LocationBloc>(
            create: (context) => LocationBloc(
              businessRepository,
            ),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(homeRepository)..getImages(),
            lazy: false,
          ),
          BlocProvider<BusinessBloc>(
            create: (context) => BusinessBloc(
              businessRepository: businessRepository,
            ),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(
              userRepository: userRepository,
            ),
          ),
        ],
        child: ZorittApp(),
      ),
    );
  }
}

class ZorittApp extends StatefulWidget {
  @override
  _ZorittAppState createState() => _ZorittAppState();
}

class _ZorittAppState extends State<ZorittApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF533C3C),
          accentColor: Color(0xffffa500),
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            elevation: 2,
            // backgroundColor: Color(0xffffa500),
            backgroundColor: Colors.white,
            // brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
            actionsIconTheme: IconThemeData(color: Colors.black),
          ),
          primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
                bodyColor: Colors.black,
                displayColor: Colors.black,
                decorationColor: Colors.black,
              ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
