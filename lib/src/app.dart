import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/screens/screens.dart';

import 'screens/posts_page/posts_page.dart';

class ZoritBusinessOwner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ZorittApp();
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
      // initialRoute: PostsPage.pathName,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
