//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/screens/chat_screen.dart';
import 'package:intl/intl.dart';

class ForumCard extends StatefulWidget {
  @override
  _ForumCardState createState() => _ForumCardState();
}

class _ForumCardState extends State<ForumCard> {
  String uid = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    final user = await _auth.currentUser;
    uid = user.uid;

    print(uid);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('forums')
          .orderBy('sentAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final chatDocuments = snapshot.data.docs;

        return ListView.builder(
            itemCount: chatDocuments.length,
            itemBuilder: (ctx, index) => InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                documentId: snapshot.data.docs[index].id,
                              ))),
                  child: Card(
                    color: login_bg,
                    elevation: 8,
                    child: ListTile(
                      title: Text(chatDocuments[index]['title']),
                      subtitle: Text(DateFormat('dd-MM-yyyy HH:mm')
                          .format(chatDocuments[index]['sentAt'].toDate())),
                      trailing: IconButton(
                          icon: Icon(uid == chatDocuments[index]['userId']
                              ? Icons.delete
                              : null),
                          onPressed: () async {
                            await FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              await myTransaction
                                  .delete(snapshot.data.docs[index].reference);
                            });
                          }),
                    ),
                  ),
                ));
      },
    );
  }
}
