import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/components/ratingbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class tempRating extends StatefulWidget {
  const tempRating({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _tempRatingState createState() => _tempRatingState();
}

class _tempRatingState extends State<tempRating> {
  _submit() async {
    final user = await FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RatingBarScreen(id: widget.id),
    );
  }
}
