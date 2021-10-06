import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:zoritt_mobile_app_user/src/app-theme.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';
import 'package:zoritt_mobile_app_user/src/repository/home/home_repository.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';

import 'client/client.dart';

class ZorittApp extends StatefulWidget {
  const ZorittApp({Key key}) : super(key: key);

  @override
  _ZorittAppState createState() => _ZorittAppState();
}

class _ZorittAppState extends State<ZorittApp> {
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
        child: AppTheme(),
      ),
    );
  }
}
