import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final String name;
  const Orders({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('booked')
            .where('name', isEqualTo: name)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final ordDoc = snapshot.data.docs;
          return Scaffold(
              appBar: AppBar(
                title: Text('My Orders'),
              ),
              body: Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ordDoc.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {},
                          child: Container(
                            color: login_bg,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${ordDoc[index]['product']}\n${ordDoc[index]['request']}'),
                                // Text(reqDoc[index]['time'].toDate()),
                                Text(ordDoc[index]['number'].toString())
                              ],
                            ),
                          ),
                        )),
              ));
        });
  }
}
