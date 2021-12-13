//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flavor_fog/components/persistent_widget_tab.dart';
import 'package:flavor_fog/notif_plugin.dart';
import 'package:flavor_fog/screens/args.dart';
import 'package:flavor_fog/screens/auth_screen.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flavor_fog/screens/extract.dart';
import 'package:flavor_fog/screens/forums.dart';
import 'package:flavor_fog/screens/home/components/home_header.dart';
import 'package:flavor_fog/screens/home/home_screen.dart';
import 'package:flavor_fog/screens/myshop/components/reqdetail.dart';
import 'package:flavor_fog/screens/myshop/components/requests.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/routes.dart';
import 'package:flavor_fog/screens/splash/splash_screen.dart';
import 'package:flavor_fog/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

// GlobalKey<NavigatorState> globals = GlobalKey<NavigatorState>();
void main() async {
  // final GlobalKey<NavigatorState> navigatorKey =
  //     new GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // await NotifPlugin().initialise();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

String _tokenId;

class _MyAppState extends State<MyApp> {
  String name = "";
  String shopId = "";
  String _debugLabelString = "";
  String _emailAddress;
  String _smsNumber;
  String _externalUserId;
  bool _enableConsentButton = false;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent
  bool _requireConsent = true;
  Future<void> initPlatformState() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    // OneSignal.shared.setRequiresUserPrivacyConsent(_requireConsent);

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event}');

      /// Display Notification, send null to not display
      event.complete(event.notification);

      this.setState(() {
        _debugLabelString =
            "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      });
    });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // navigatorKey.currentState.pushNamed(Requests.routeName);
      setState(() {
        name = result.notification.additionalData['name'];
      });
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
      print('${result.notification.additionalData['name']}');

      // print(
      //     'AAAAAAAAAAAAAAAAAAA\n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}');
      // this.setState(() {
      //   _debugLabelString =
      //       "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });
    // bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    // this.setState(() {
    //   _enableConsentButton = requiresConsent;
    // });

    // // Some examples of how to use In App Messaging public methods with OneSignal SDK
    // // oneSignalInAppMessagingTriggerExamples();

    // // Some examples of how to use Outcome Events public methods with OneSignal SDK
    // // oneSignalOutcomeEventsExamples();

    // bool userProvidedPrivacyConsent =
    //     await OneSignal.shared.userProvidedPrivacyConsent();
    // print("USER PROVIDED PRIVACY CONSENT: $userProvidedPrivacyConsent");
  }

  final user = FirebaseAuth.instance.currentUser;
  void inputData() async {
    var status = await OneSignal.shared.getDeviceState();
    setState(() {
      _tokenId = status.userId;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid) // <-- Document ID
        .update({
      "token": _tokenId,
    }).catchError((error) => print('Add failed: $error'));

    final shopDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (shopDoc.data().containsValue("hasShop")) {
        shopId = shopDoc['shopId'];
        FirebaseFirestore.instance
            .collection('shop')
            .doc(shopDoc['shopId'])
            .update({
          "token": _tokenId,
        }).catchError((error) => print('Add failed: $error'));
      }
      // here you write the codes to input the data into firestore
    });
  }

  @override
  void initState() {
    super.initState();
    configOneSignel();
    initPlatformState();
    // OneSignal.shared.setExternalUserId(user.uid);
    inputData();
    // OneSignal.shared.disablePush(false);
    // OneSignal.shared.setNotificationOpenedHandler((openedResult) {
    //   print(openedResult.notification.rawPayload.toString());
    // });
  }

  void configOneSignel() {
    OneSignal.shared.setAppId('6c81e907-87b4-4bd4-b56c-68382ca36a11');
  }

  // void _handleNotificationOpened(OSNotificationOpenedResult result) {
  //   print('[notification_service - _handleNotificationOpened()');
  //   print(
  //       "Opened notification: ${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");

  //   // Since the only thing we can get current are new Alerts -- go to the Alert screen
  //   globals.currentState.pushNamed('/home');
  // }

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
      title: 'Flavour Fog',
      navigatorKey: widget.key,
      // navigatorKey: globals,

      // theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: _user(),
      home: user != null
          ? name == null || name == ""
              ? ProvidedStylesExample(
                  menuScreenContext: context,
                  name: name,
                  shopId: shopId,
                )
              : ReqDetail(
                  name: name,
                  shopId: shopId,
                )
          : AuthScreen(),
      routes: routes,
    );
  }
}
