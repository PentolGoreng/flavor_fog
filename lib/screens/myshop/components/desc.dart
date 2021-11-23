//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DescScreen extends StatefulWidget {
  DescScreen({Key key, this.shopId}) : super(key: key);
  final String shopId;
  @override
  State<DescScreen> createState() => _DescScreenState();
}

class _DescScreenState extends State<DescScreen> {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('shops')
          .doc(widget.shopId)
          .snapshots(),
      builder: (context, snapshot) {
        print(widget.shopId);
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userImage = snapshot.data;
        String address = userImage["address"];
        String name = userImage["title"];
        print(widget.shopId);

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.shopId),
                    Text(
                      name,
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email'),
                    Text(
                      name,
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text('Click to make changes',
                        style: TextStyle(color: Colors.grey, fontSize: 13)))
              ],
            ),
          ),
        );
      },
    );

    // SizedBox(
    //   height: 115,
    //   width: 115,
    //   child: Stack(
    //     fit: StackFit.expand,
    //     clipBehavior: Clip.none,
    //     children: [
    //       CircleAvatar(
    //         backgroundImage: AssetImage("assets/images/Profile Image.png"),
    //       ),
    //       Positioned(
    //         right: -16,
    //         bottom: 0,
    //         child: SizedBox(
    //           height: 46,
    //           width: 46,
    //           child: TextButton(
    //             style: TextButton.styleFrom(
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(50),
    //                 side: BorderSide(color: Colors.white),
    //               ),
    //               primary: Colors.white,
    //               backgroundColor: Color(0xFFF5F6F9),
    //             ),
    //             onPressed: () {},
    //             child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
