//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String documentId;
  NewMessage({Key key, this.documentId}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _newMessage = '';

  final _controller = TextEditingController();

  void _send() async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance
        .collection('forums')
        .doc(widget.documentId)
        .collection('chats')
        .add({
      'text': _newMessage,
      'sentAt': Timestamp.now(),
      'userId': user.uid,
      'name': userData['name'],
      'image': userData['image'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter a message',
            ),
            onChanged: (value) {
              setState(() {
                _newMessage = value;
              });
              print(widget.documentId);
            },
          )),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: _controller.text.trim().isEmpty ? null : _send)
        ],
      ),
    );
  }
}
