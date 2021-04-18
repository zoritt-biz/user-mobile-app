import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/navigation/navigation_bloc.dart';
import 'package:zoritt_mobile_app_user/src/repository/event/events_repository.dart';
import 'package:zoritt_mobile_app_user/src/repository/repository.dart';
import 'package:zoritt_mobile_app_user/src/screens/screens.dart';

import 'client/client.dart';

class ZoritBusinessUser extends StatelessWidget {
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository(
    firebaseAuth: FirebaseAuth.instance,
    userRepository: UserRepository(client: client()),
  );

  final EventsRepository eventsRepository = EventsRepository(client: client());

  final PostRepository postRepository = PostRepository(client: client());

  final CategoryRepository categoryRepository = CategoryRepository(
    client: client(),
  );

  final BusinessRepository businessRepository = BusinessRepository(
    client: client(),
    firebaseStorage: FirebaseStorage.instance,
  );

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: eventsRepository),
        RepositoryProvider.value(value: postRepository),
        RepositoryProvider.value(value: businessRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository:
                  context.read<AuthenticationRepository>(),
            ),
            lazy: false,
          ),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
            lazy: false,
          ),
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
              categoryRepository: categoryRepository,
            ),
          ),
          BlocProvider<BusinessBloc>(
            create: (context) => BusinessBloc(
              businessRepository: businessRepository,
            ),
          )
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
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffFFA500),
        accentColor: Color(0xFF10B49E),
        appBarTheme: AppBarTheme(
          elevation: 2,
          backgroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
