import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/screens/routes/route_generator.dart';

class AppTheme extends StatefulWidget {
  @override
  _AppThemeState createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
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
