//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({
    Key key,
  }) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

final user = FirebaseAuth.instance.currentUser;
String _uid = user.uid;

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .collection('cart')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final checkDB = snapshot.data.docs;

            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: _uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final checkDB1 = snapshot.data.docs;

                  return Container(
                    color: login_bg,
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(checkDB1[0]['address'] == null
                                ? '+ Add address'
                                : checkDB1[0]['address']),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: checkDB.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${checkDB[index]['title']}",
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                    Text(
                                      "${checkDB[index]['price']}",
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('x${checkDB[index]['total']}'),
                                    Text(
                                      ((checkDB[index]['total']) *
                                              int.parse(
                                                  checkDB[index]['price']))
                                          .toString(),
                                      style: TextStyle(color: kPrimaryColor),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
