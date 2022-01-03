import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flavor_fog/screens/myshop/components/reqdetail.dart';
import 'package:flavor_fog/screens/myshop/components/requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path/path.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'main.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class NotifPlugin {
  Future initialise() async {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Display Notification, send null to not display, send notification to display
      event.complete(event.notification);
    });
    Future<void> firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      print("Handling a background message ||||||||||||||||");
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        // print('onMessage : $message');
        _navigate(message.toString());
      },
    );
    // OneSignal.shared.setNotificationOpenedHandler((openedResult) async {
    //   var additionalData = openedResult.notification.additionalData;
    //   if (additionalData != null) {
    //     if (additionalData.containsKey("myKey")) {
    //       var myValue = additionalData["myKey"];
    //       print(
    //           'AAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
    //     }
    //   }
    // });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // navigatorKey.currentState.pushNamed(Requests.routeName);
      // _navigate(ReqDetail.routeName);
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
      print('222222222${result.notification.additionalData!['name']}');

      // print(
      //     'AAAAAAAAAAAAAAAAAAA\n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}');
      // this.setState(() {
      //   _debugLabelString =
      //       "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        // print('onLaunch : $message');
        _navigate(message.toString());
      },
    );
  }

  void _navigate(String message) {
    var notifData = message;
    // var view = notifData['view'];

    if (message != null) {
      navigatorKey.currentState!.push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ReqDetail(
            name: message,
          ),
        ),
      );

      print(' ini pesan MESSAGE ${message}');
    }
  }
}
