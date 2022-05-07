//@dart=2.9

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/models/ChatMessage.dart';
import 'package:flavor_fog/screens/account/account_screen.dart';
import 'package:flavor_fog/screens/myshop/myshop_screen.dart';
import 'package:flavor_fog/screens/profile/components/help.dart';
import 'package:flavor_fog/screens/profile/components/orders.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flavor_fog/temprating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/screens/auth_screen.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  setName() async {
    final shopDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      setState(() {
        // print('Document data: ${documentSnapshot.data()}' +
        //     'a');

        name = shopDoc["name"];
      });
    });
  }

  void getUser() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
  }

  final FirebaseStorage storage = FirebaseStorage.instanceFor(
      app: FirebaseFirestore.instance.app,
      bucket: 'gs://my-project.appspot.com');
  String name;
  String errorMsg;

  _BodyState() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
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
      // 'shop': '',
      'userId': user.uid,
      'token': _tokenId,
      'image':
          'https://firebasestorage.googleapis.com/v0/b/flavour-fog.appspot.com/o/Profile%2Fprofile.jpg?alt=media&token=ddf7ce8f-70b7-40c9-beaf-e4fb8688c6d8'
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

  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  YoutubePlayerController _controllerPlayer;
  TextEditingController shopController = TextEditingController();
  TextEditingController addrController = TextEditingController();
  String _tokenId;
  @override
  void _getData() async {
    var status = await OneSignal.shared.getDeviceState();
    setState(() {
      _tokenId = status.userId;
    });
  }

  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: '1AlOyHo-E7M',
    flags: YoutubePlayerFlags(
        autoPlay: true, mute: false, forceHD: false, startAt: 00),
  );
  void listener() {
    if (_isPlayerReady) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // _controller = YoutubePlayerController(
    //   initialVideoId: "1AlOyHo-E7M",
    //   flags: const YoutubePlayerFlags(
    //     mute: false,
    //     autoPlay: true,
    //     disableDragSeek: false,
    //     loop: false,
    //     isLive: false,
    //     forceHD: false,
    //     enableCaption: true,
    //   ),
    // )..addListener(listener);
  }

  Widget build(BuildContext context) {
    _getData();

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
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () => {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return HelpScreen();
                        },
                      ),
                    )
                  }),
          ProfileMenu(
            color: Color(0xFF212121),
            text: "My Orders",
            icon: "assets/icons/Mail.svg",
            press: () {
              pushNewScreen(context,
                  screen: Orders(name: name),
                  pageTransitionAnimation: PageTransitionAnimation.slideUp);
            },
          ),

          ProfileMenu(
              color: Color(0xFF212121),
              text: "Tutorial",
              icon: "assets/icons/Question mark.svg",
              press: () {
                _showDialog1(context);
                _controller.reset();
                // _controller.reload();
                // setState(() {
                //   _isPlayerReady = true;
                // });
              }),
          ProfileMenu(
            color: Color(0xFF212121),
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              OneSignal.shared.disablePush(false);
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
                        setState(() {
                          // print('Document data: ${documentSnapshot.data()}' +
                          //     'a');
                          String shopId = shopDoc["shopId"];
                          name = shopDoc["name"];
                          pushNewScreen(context,
                              screen: MyShopScreen(
                                token: _tokenId,
                                shopId: shopId,
                                name: name,
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

  void _showDialog1(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) => Container(
              color: login_bg,
              padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: kPrimaryColor,
                progressColors: ProgressBarColors(
                  playedColor: kPrimaryColor,
                  handleColor: kPrimaryColor,
                ),
                onReady: () {
                  // _controller.addListener(listener);
                },
              ),
            ));
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
                Expanded(
                  child: Center(
                    child: Text(
                      'Create your own Shop',
                      style: TextStyle(fontSize: 20),
                    ),
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
