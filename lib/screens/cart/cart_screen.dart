//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/models/cart.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  final _user = FirebaseAuth.instance.currentUser;
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(context),
      body: Body(),
      // bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Cart",
            style: TextStyle(color: Colors.black),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_user.uid)
                  .collection('cart')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final _data = snapshot.data.docs;
                return Text(
                  "${_data.length} items",
                  style: Theme.of(context).textTheme.caption,
                );
              }),
        ],
      ),
    );
  }
}
