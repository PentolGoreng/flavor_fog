//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/components/persistent_widget_tab.dart';
import 'package:flavor_fog/notif_plugin.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  await NotifPlugin().initialise();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    configOneSignel();
    OneSignal.shared.setExternalUserId(user.uid);
    OneSignal.shared.disablePush(false);
  }

  void configOneSignel() {
    OneSignal.shared.setAppId('6c81e907-87b4-4bd4-b56c-68382ca36a11');
  }

  @override
  Widget build(BuildContext context) {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
// const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('app_icon');
// final IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
// final MacOSInitializationSettings initializationSettingsMacOS =
//     MacOSInitializationSettings();
// final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//     macOS: initializationSettingsMacOS);
// await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     onSelectNotification: selectNotification);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeData(context),
      // darkTheme: darkThemeData(context),
      title: 'Flutter Demo',
      navigatorKey: widget.key,
      // theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: _user(),
      home:
          // user != null
          // ? ProvidedStylesExample(menuScreenContext: context)
          // :
          AuthScreen(),
      routes: routes,
    );
  }
}
