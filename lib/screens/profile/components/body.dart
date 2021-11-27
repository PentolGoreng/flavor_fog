//@dart=2.9

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/models/ChatMessage.dart';
import 'package:flavor_fog/screens/account/account_screen.dart';
import 'package:flavor_fog/screens/myshop/myshop_screen.dart';
import 'package:flavor_fog/temprating.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/screens/auth_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void getUser() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
  }

  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      app: FirebaseFirestore.instance.app,
      bucket: 'gs://my-project.appspot.com');

  Uint8List imageBytes;
  String errorMsg;

  _BodyState() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;

    storage
        .ref()
        .child('Profile/${uid}.png')
        .getData(10000000)
        .then((data) => setState(() {
              imageBytes = data;
            }))
        .catchError((e) => setState(() {
              errorMsg = e.error;
            }));
  }
  var _newShop = '';
  var _newShop1 = '';
  _submit() async {
    final user = await FirebaseAuth.instance.currentUser;

    final shopData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('shops').add({
      'title': shopController.text,
      'address': addrController.text,
      'creationTime': Timestamp.now(),
      'shopId': '',
      'shop': '',
      'userId': user.uid,
      // 'shopImage': shopData['image'],
    });
    FirebaseFirestore.instance.collection('shops').doc(docRef.id).update({
      'shopId': docRef.id,
    });
    shopController.clear();
    addrController.clear();

    FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'shopId': docRef.id,
      'shop': 'hasShop',
    });
  }

  TextEditingController shopController = TextEditingController();
  TextEditingController addrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            color: Color(0xFF212121),
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              pushNewScreen(context,
                  screen: AccountScreen(),
                  pageTransitionAnimation: PageTransitionAnimation.slideUp)
            },
          ),
          // ProfileMenu(
          //   color: Color(0xFF212121),
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   press: () => {},
          // ),
          ProfileMenu(
            color: Color(0xFF212121),
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            color: Color(0xFF212121),
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            color: Color(0xFF212121),
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AuthScreen();
                  },
                ),
                (_) => false,
              );
            },
          ),

          // Spacer(
          //   flex: 1,
          // ),

          Align(
              alignment: Alignment.bottomCenter,
              child: (ProfileMenu(
                  color: kPrimaryColor,
                  text: "My Shop",
                  icon: "assets/icons/Log out.svg",
                  press: () async {
                    String uid = FirebaseAuth.instance.currentUser.uid;
                    final shopDoc = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .get();

                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (shopDoc.data().containsValue("hasShop")) {
                        setState(() {
                          // print('Document data: ${documentSnapshot.data()}' +
                          //     'a');
                          String shopId = shopDoc["shopId"];
                          pushNewScreen(context,
                              screen: MyShopScreen(
                                shopId: shopId,
                              ));
                        });
                      } else if (!shopDoc.data().containsValue("hasShop")) {
                        setState(() {
                          _showDialog(context);
                        });
                      }
                      // if (documentSnapshot.exists) {
                      //   print('Document data: ${documentSnapshot.data()}');
                      //   String shopId = shopDoc["shopId"];

                      //   try {
                      //     dynamic nested =
                      //         documentSnapshot.get(FieldPath(['shopId']));
                      //   } on StateError catch (e) {
                      //     print(e);
                      //   }
                      // } else {}
                    });
                  }))),
          SizedBox(
            height: kBottomNavigationBarHeight,
          ),
        ]));
  }

  void _showDialog(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (_) => Container(
            color: login_bg,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    'Create your own Shop',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(hintText: "Shop Name"),
                  maxLength: 20,
                  controller: shopController,
                  onChanged: (text) {
                    setState(() {
                      _newShop = text;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Shop Address"),
                  maxLines: 5,
                  maxLength: 50,
                  controller: addrController,
                  onChanged: (text) {
                    setState(() {
                      _newShop1 = text;
                    });
                  },
                ),
                // TextField(),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (shopController.text.trim().isEmpty ||
                        addrController.text.trim().isEmpty) {
                      return null;
                    } else {
                      _submit();
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
                SizedBox(
                  height: kBottomNavigationBarHeight,
                )
              ],
            )));
  }
}
