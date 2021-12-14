//@dart=2.9

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatefulWidget {
  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  // var imageRef = await usersCollection.doc('$user').get();

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
        String image = userImage["image"];
        return SizedBox(
            height: 115,
            width: 115,
            child:
                Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
              // Container(
              //     decoration: BoxDecoration(
              //   shape: BoxShape.circle,
              //   image: DecorationImage(
              //     image: Image.network(
              //       image,
              //       errorBuilder: (BuildContext context, Object exception,
              //           StackTrace stackTrace) {
              //         return Image.asset('assets/images/profileakun.png');
              //       },
              //     ),
              //     fit: BoxFit.cover,
              //   ),
              // )),
              Container(
                  decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    '$image',
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
  }
}
   
    // Stream<DocumentSnapshot> getImg(){ return
    //   db.collection("Users").doc('$user').snapshots();};
   


    // return SizedBox(
    //   height: 115,
    //   width: 115,
    //   child: Stack(
    //     fit: StackFit.expand,
    //     clipBehavior: Clip.none,
    //     children: [
        
        
    //      CircleAvatar(
    //         child: Image.network('https://picsum.photos/250?image=9'),
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