// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zoritt_mobile_app_user/src/app.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  await initHiveForFlutter();

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // final storage = FlutterSecureStorage();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ZorittApp());
}
