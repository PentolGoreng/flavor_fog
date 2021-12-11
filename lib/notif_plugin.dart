import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
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

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        // print('onMessage : $message');
        _navigate(message);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        // print('onLaunch : $message');
        _navigate(message);
      },
    );
  }

  void _navigate(RemoteMessage message) {
    var notifData = message;
    // var view = notifData['view'];

    if (message != null) {
      // if (view == "request") {
      //   navigatorKey.currentState!.pushNamed("/request");
      // }
      print(' ini pesan MESSAGE ${message}');
    }
  }
}
