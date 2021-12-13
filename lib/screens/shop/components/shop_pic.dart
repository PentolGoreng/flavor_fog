//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShopPic extends StatefulWidget {
  ShopPic({Key key, this.images}) : super(key: key);
  final String images;
  @override
  State<ShopPic> createState() => _ShopPicState();
}

class _ShopPicState extends State<ShopPic> {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc('${user.uid}')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userImage = snapshot.data;
        // String image = userImage["image"];
        return SizedBox(
            height: 115,
            width: 115,
            child:
                Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
              Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        '${widget.images}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  )),
              // Positioned(
              //   right: -16,
              //   bottom: 0,
              //   child: SizedBox(
              //     height: 46,
              //     width: 46,
              //     child: TextButton(
              //       style: TextButton.styleFrom(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(50),
              //           side: BorderSide(color: Colors.white),
              //         ),
              //         primary: Colors.white,
              //         backgroundColor: Color(0xFFF5F6F9),
              //       ),
              //       onPressed: () {},
              //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              //     ),
              //   ),
              // )
            ]));
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
