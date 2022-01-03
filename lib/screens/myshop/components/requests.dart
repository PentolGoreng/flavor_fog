//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flavor_fog/screens/myshop/components/reqdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flavor_fog/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Requests extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  final String shopId;
  Requests({Key key, this.shopId, this.navigatorKey}) : super(key: key);
  static String routeName = "/request";
  @override
  _RequestsState createState() => _RequestsState();
}

extension StringExtension on String {
  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? 's' : '';

    return timeAgo + ' ago';
  }
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
            .doc(widget.shopId)
            .collection('request')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final reqDoc = snapshot.data.docs;
          // DatabaseReference ref =
          //     FirebaseDatabase.instance.ref("${_shop}/request/");
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
          //     mapData.add(values);
          //   });
          // });
          return Scaffold(
              appBar: AppBar(
                title: Text('Requests'),
              ),
              body: Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: reqDoc.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            pushNewScreen(context,
                                screen: ReqDetail(
                                    shopId: widget.shopId,
                                    doc: reqDoc[index]['doc'],
                                    // i: index,
                                    name: reqDoc[index]['name']));
                          },
                          child: Container(
                            color: login_bg,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${reqDoc[index]['title']}\n${reqDoc[index]['name']}'),
                                // Text(reqDoc[index]['time'].toDate()),
                                Text(
                                    StringExtension.displayTimeAgoFromTimestamp(
                                        reqDoc[index]['time']
                                            .toDate()
                                            .toString()))
                              ],
                            ),
                          ),
                        )),
              )
              // TextButton(
              //   child: Text(test == "" || test == null ? _shop : test),
              //   onPressed: () {
              //     print(mapData);
              //     // for (var i = 0; i < checkDB.length; i++) {
              //     //                     await FirebaseDatabase(
              //     //                             databaseURL:
              //     //                                 "https://flavour-fog-default-rtdb.asia-southeast1.firebasedatabase.app")
              //     //                         // .instance
              //     //                         .ref(
              //     //                             "${checkDB[0]['shop']}/request/$_uid/${checkDB[i]['title']}")
              //     //                         .set({
              //     //                       "request": "waiting",
              //     //                       "id": checkDB[i]['productId'],
              //     //                       "title": checkDB[i]['title'],
              //     //                       "price": checkDB[i]['price'],
              //     //                       "number": checkDB[i]['total'],
              //     //                     });
              //     //                   }
              //   },
              // ),
              );
        });
  }
}
