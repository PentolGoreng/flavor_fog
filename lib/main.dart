//@dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/components/persistent_widget_tab.dart';
import 'package:flavor_fog/screens/auth_screen.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flavor_fog/screens/forums.dart';
import 'package:flavor_fog/screens/home/components/home_header.dart';
import 'package:flavor_fog/screens/home/home_screen.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/routes.dart';
import 'package:flavor_fog/screens/splash/splash_screen.dart';
import 'package:flavor_fog/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeData(context),
      // darkTheme: darkThemeData(context),
      title: 'Flutter Demo',
      // theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: _user(),
      home: user != null
          ? ProvidedStylesExample(menuScreenContext: context)
          : AuthScreen(),
      routes: routes,
    );
  }
}
