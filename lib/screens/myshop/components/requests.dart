//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flavor_fog/constants.dart';

class Requests extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  final String shopId;
  Requests({Key key, this.shopId, this.navigatorKey}) : super(key: key);
  static String routeName = "/request";
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  String test;
  List<Map<Key, String>> mapData;
  String _shop;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('shops')
            .where('shopId', isEqualTo: '${widget.shopId}')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          _shop = snapshot.data.docs[0]['title'];
          DatabaseReference ref =
              FirebaseDatabase.instance.ref("${_shop}/request/");
          // FirebaseDatabase.instance
          //     .ref()
          //     .child("${checkDB[0]['shop']}/request/$_uid");

// Get the Stream
          Stream<DatabaseEvent> stream = ref.onValue;
          stream.listen((DatabaseEvent event) {
            print('Event Type: ${event.type}'); // DatabaseEventType.value;
            print('Snapshot: ${event.snapshot}');

            Map<dynamic, dynamic> values = event.snapshot.value;
            values.forEach((key, values) {
              print(values["title"]);
              print(values["price"]);
              mapData.add(values);
            });
          });
          return Container(
            child: TextButton(
              child: Text(test == "" || test == null ? _shop : test),
              onPressed: () {
                print(mapData);
                // for (var i = 0; i < checkDB.length; i++) {
                //                     await FirebaseDatabase(
                //                             databaseURL:
                //                                 "https://flavour-fog-default-rtdb.asia-southeast1.firebasedatabase.app")
                //                         // .instance
                //                         .ref(
                //                             "${checkDB[0]['shop']}/request/$_uid/${checkDB[i]['title']}")
                //                         .set({
                //                       "request": "waiting",
                //                       "id": checkDB[i]['productId'],
                //                       "title": checkDB[i]['title'],
                //                       "price": checkDB[i]['price'],
                //                       "number": checkDB[i]['total'],
                //                     });
                //                   }
              },
            ),
          );
        });
  }
}
