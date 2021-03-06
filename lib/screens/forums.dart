//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/widgets/forum_card.dart';

class ForumsScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const ForumsScreen(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);
  static String routeName = "/forum";
  @override
  _ForumsScreenState createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController forumController = TextEditingController();
  _submit() async {
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('forums').add({
      'title': titleController.text,
      'sentAt': Timestamp.now(),
      'userId': user.uid,
      'firstName': userData['name'],
      'userImage': userData['image'],
      'topic': forumController.text,
    });
    Navigator.pop(context);
    titleController.clear();
  }

  var _newTitle = '';
  var _newTopic = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Forums'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: ForumCard()),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: kBottomNavigationBarHeight * 2,
      ),
    );
  }

  void _showDialog(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (_) => Column(
              children: [
                Center(
                  child: Text('Start a discussion'),
                ),
                TextField(
                  controller: titleController,
                  onChanged: (text) {
                    setState(() {
                      _newTitle = text;
                    });
                  },
                ),
                TextField(
                  controller: forumController,
                  onChanged: (text) {
                    setState(() {
                      _newTopic = text;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    titleController.text.trim().isEmpty ? null : _submit();
                  },
                  child: Text('Submit'),
                )
              ],
            ));
  }
}
