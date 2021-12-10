//@dart=2.9
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../size_config.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({
    Key key,
    this.selected,
    this.shopId,
    this.token,
  }) : super(key: key);
  final String selected;
  final String shopId;
  final String token;
  @override
  _CheckOutState createState() => _CheckOutState();
}

final user = FirebaseAuth.instance.currentUser;
String _uid = user.uid;

class _CheckOutState extends State<CheckOut> {
  List<String> daftar;
  String deliv = "";
  FirebaseDatabase database = FirebaseDatabase.instance;
  String _newAdd;
  int number;
  TextEditingController _addressC = TextEditingController();

  Future<Response> sendNotification(
      List<String> tokenIdList, String contents, String heading) async {
    return await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id":
            "6c81e907-87b4-4bd4-b56c-68382ca36a11", //kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids":
            tokenIdList, //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color": "FF9976D2",

        "small_icon": "ic_stat_onesignal_default",

        "large_icon":
            "https://www.filepicker.io/api/file/zPloHSmnQsix82nlj9Aj?filename=name.jpg",

        "headings": {"en": heading},

        "contents": {"en": contents},
      }),
    );
  }

  String tokenId;
  _getToken() async {
    var status = await OneSignal.shared.getDeviceState();
    setState(() {
      tokenId = status.userId;
    });
  }

  String name;
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot snapshot) => name = snapshot['name']);
    daftar.fillRange(0, 0, widget.token);
    _getToken();
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .collection('cart')
              .where('shop', isEqualTo: widget.selected)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(child: CircularProgressIndicator());
            // }
            final checkDB = snapshot.data.docs;

            // DocumentReference<Map<String, dynamic>> documentReference;
            DatabaseReference ref = FirebaseDatabase.instance
                .ref("${checkDB[0]['shop']}/request/$_uid");
            // FirebaseDatabase.instance
            //     .ref()
            //     .child("${checkDB[0]['shop']}/request/$_uid");

// Get the Stream
            // Stream<DatabaseEvent> stream = ref.onValue;
            // stream.listen((DatabaseEvent event) {
            //   print('Event Type: ${event.type}'); // DatabaseEventType.value;
            //   print('Snapshot: ${event.snapshot}');

            //   Map<dynamic, dynamic> values = event.snapshot.value;
            //   values.forEach((key, values) {
            //     print(values["title"]);
            //     print(values["price"]);
            //     deliv = values["request"];
            //   });
            // });
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: _uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return Center(child: CircularProgressIndicator());
                  // }
                  final checkDB1 = snapshot.data.docs;

                  return Container(
                    color: login_bg,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 50),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Address :")),
                                Container(
                                    // decoration: BoxDecoration(
                                    //   boxShadow: [
                                    //     BoxShadow(
                                    //       color: Colors.black,
                                    //     ),
                                    //     BoxShadow(
                                    //         color: login_bg,
                                    //         offset:
                                    //             Offset.fromDirection(180, 5),
                                    //         blurRadius: 2,
                                    //         spreadRadius: 3),
                                    //   ],
                                    // ),
                                    height: 40,
                                    child: Align(
                                      alignment: checkDB1[0]['address'] == ""
                                          ? Alignment.center
                                          : Alignment.centerRight,
                                      child: GestureDetector(
                                          onTap: () {
                                            if (checkDB1[0]['address'] != "") {
                                              _addressC = TextEditingController(
                                                  text: checkDB1[0]['address']);
                                            }
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              25.0)),
                                                ),
                                                context: context,
                                                builder: (_) => Container(
                                                    color: login_bg,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            'Address',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        TextField(
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Address details"),
                                                          maxLength: 150,
                                                          maxLines: 4,
                                                          controller: _addressC,
                                                          onChanged: (text) {},
                                                        ),

                                                        // TextField(),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                            if (_addressC.text
                                                                    .trim()
                                                                    .isEmpty ||
                                                                _addressC.text
                                                                    .trim()
                                                                    .isEmpty) {
                                                              return null;
                                                            } else {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(user.uid)
                                                                  .update({
                                                                'address':
                                                                    _addressC
                                                                        .text
                                                              });
                                                            }
                                                            _addressC.clear();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(checkDB1[
                                                                          0][
                                                                      'address'] ==
                                                                  ""
                                                              ? 'Add Address'
                                                              : 'Update Address'),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              kBottomNavigationBarHeight,
                                                        )
                                                      ],
                                                    ))).whenComplete(() {
                                              _addressC.clear();
                                            });
                                          },
                                          child: Text(
                                            checkDB1[0]['address'] == "" ||
                                                    checkDB1[0]['address'] ==
                                                        null
                                                ? '+ Add address'
                                                : checkDB1[0]['address'],
                                            style: TextStyle(
                                                fontSize:
                                                    checkDB1[0]['address'] == ""
                                                        ? 15
                                                        : 12,
                                                color:
                                                    checkDB1[0]['address'] == ""
                                                        ? kPrimaryColor
                                                        : kPrimaryColor),
                                            textAlign:
                                                checkDB1[0]['address'] == ""
                                                    ? TextAlign.center
                                                    : TextAlign.right,
                                          )),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: Text(
                                  'Tap on your address to edit',
                                  style: TextStyle(color: Colors.grey.shade700),
                                )),
                              ],
                            )),
                        Expanded(
                          child: ListView.builder(
                            itemCount: checkDB.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 70,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image(
                                                  image: NetworkImage(
                                                      checkDB[index]['image']
                                                          .toString())),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${checkDB[index]['title']}\nx${checkDB[index]['total']}",
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text("${checkDB[index]['price']}"),
                                        Text(
                                            "${((checkDB[index]['total']) * int.parse(checkDB[index]['price']))}")
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: deliv == null ||
                                    deliv == "" ||
                                    deliv == "waiting"
                                ? Text('Waiting')
                                : Text(deliv),
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              // for (var i = 0; i < checkDB.length; i++) {
                              //   await FirebaseFirestore.instance
                              //       .collection('request')
                              //       .doc(widget.shopId)
                              //       .collection(widget.selected)
                              //       .doc(checkDB[i]['title'])
                              //       .set({
                              //     "request": "waiting",
                              //     "id": checkDB[i]['productId'],
                              //     "title": checkDB[i]['title'],
                              //     "price": checkDB[i]['price'],
                              //     "number": checkDB[i]['total'],
                              //     "shop": widget.selected,
                              //     "token": tokenId,
                              //     "shopId": widget.shopId,
                              //   });
                              sendNotification(daftar, "Test 1", "test");
                            },
                            child: Center(child: Text('Submit Order')))
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
