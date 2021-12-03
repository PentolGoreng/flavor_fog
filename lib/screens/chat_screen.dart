//@dart=2.9

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/widgets/message.dart';
import 'package:flavor_fog/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  final String documentId;
  final String topic;
  final String title;
  const ChatScreen({Key key, this.documentId, this.topic, this.title})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    print(widget.documentId);

    fbm.requestPermission(alert: true);
    FirebaseMessaging.onMessage.listen(
      (msg) {
        print(msg);
        return;
      },
    );
    FirebaseMessaging.instance.getInitialMessage().then((msg) {
      print(msg);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      print(msg);
      return;
    });
    fbm.subscribeToTopic('chats');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            // IconButton(
            //     icon: Icon(Icons.exit_to_app),
            //     onPressed: () {
            //       FirebaseAuth.instance.signOut();
            //     })
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
          child: Column(
            children: [
              MessagesWidget(
                documentId: widget.documentId,
                topic: widget.topic,
              ),
              NewMessage(
                documentId: widget.documentId,
              )
            ],
          ),
        ));
  }
}
