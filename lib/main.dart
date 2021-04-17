import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoritt_mobile_app_user/src/app.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ZoritBusinessUser());
}
