import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBarScreen extends StatefulWidget {
  const RatingBarScreen({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBarScreen> {
  void _submit() async {
    final user = await FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .collection('rating')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        FirebaseFirestore.instance
            .collection('products')
            .doc(widget.id)
            .collection('rating')
            .doc(user.uid)
            .update({
          'rating': _rating,
        });
        try {
          dynamic nested = documentSnapshot.get(FieldPath(['uid']));
        } on StateError catch (e) {
          print(e);
        }
      } else {
        FirebaseFirestore.instance
            .collection('products')
            .doc(widget.id)
            .collection('rating')
            .doc(user.uid)
            .set({
          'rating': _rating,
          'uid': user.uid,
        });
      }
    });
  }

  void rate(rate1) {
    _rating = rate1;
  }

  late double _rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              // .orderBy('sentAt', descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final userDB = snapshot.data;

            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    // .orderBy('sentAt', descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final productDB = snapshot.data;
                  // String productId = productDB["id"];
                  return Column(children: [
                    // RatingBar(
                    //   initialRating: 1,
                    //   direction: Axis.vertical,
                    //   allowHalfRating: false,
                    //   itemCount: 5,
                    //   ratingWidget: RatingWidget(
                    //     full: Image.asset(
                    //       'assets/icons/tools.png',
                    //       color: Colors.white,
                    //     ),
                    //     half: Image.asset('assets/icons/tools.png'),
                    //     empty: Image.asset(
                    //       'assets/icons/tools.png',
                    //       color: Colors.blue,
                    //     ),
                    //   ),
                    //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    //   onRatingUpdate: (rating) {
                    //     setState(() {
                    //       _rating = rating;
                    //     });
                    //   },
                    //   updateOnDrag: true,
                    // ),
                    RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: kPrimaryColor,
                            ),
                        onRatingUpdate: (rating) {
                          rate(rating);
                        }),
                    ElevatedButton(
                        onPressed: () async {
                          _submit();
                        },
                        child: Text('submit'))
                  ]);
                });
          }),
    );
  }
}
