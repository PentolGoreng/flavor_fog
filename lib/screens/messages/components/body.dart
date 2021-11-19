//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/firestore_constants.dart';
import 'package:flavor_fog/models/ChatMessage.dart';
import 'package:flavor_fog/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SharedPreferences prefs;

  FirebaseFirestore firebaseFirestore;

  FirebaseStorage firebaseStorage;

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return firebaseFirestore
        // .collection(FirestoreConstants.pathMessageCollection)
        .collection('forum')
        .doc('chats')
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

// MessageChat messageChat = MessageChat(
//       idFrom: currentUserId,
//       idTo: peerId,
//       timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
//       content: content,
//       type: type,
//     );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('forum')
            .doc('chats')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return Column(
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF212121),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child:
                          // ListView.builder(
                          //   itemCount: demeChatMessages.length,
                          //   itemBuilder: (context, index) =>
                          //       Message(message: demeChatMessages[index]),
                          // ),
                          ListView(
                              children: documents
                                  .map((doc) => Card(
                                        child: ListTile(
                                          title: Text(doc['sender']),
                                          subtitle: Text(doc['text']),
                                        ),
                                      ))
                                  .toList())),
                ),
                ChatInputField(),
                SizedBox(height: kBottomNavigationBarHeight),
              ],
            );
          }
        });
  }
}
