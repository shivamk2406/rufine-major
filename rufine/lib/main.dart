import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rufine/auth_service.dart';

import 'package:rufine/ml_service.dart';
import 'package:rufine/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rufine/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            //MLService()
            Wrapper(),
      ),
    );
  }
}
