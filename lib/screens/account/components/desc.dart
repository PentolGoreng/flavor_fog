//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DescScreen extends StatefulWidget {
  DescScreen({
    Key key,
  }) : super(key: key);

  @override
  State<DescScreen> createState() => _DescScreenState();
}

String _newAdd;
TextEditingController _addressC = TextEditingController();
String _newName;
TextEditingController _nameC = TextEditingController();

class _DescScreenState extends State<DescScreen> {
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
        String image = userImage["image"];
        String name = userImage["name"];
        String email = userImage["email"];

        String address = userImage['address'];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name'),
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
                      email,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Address'),
                    GestureDetector(
                      onTap: () {
                        if (userImage['address'] != "") {
                          _addressC =
                              TextEditingController(text: userImage['address']);
                        }
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                            ),
                            context: context,
                            builder: (_) => Container(
                                color: login_bg,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Address',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Spacer(),
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: "Address details"),
                                      maxLength: 150,
                                      maxLines: 4,
                                      controller: _addressC,
                                      onChanged: (text) {
                                        setState(() {
                                          _newAdd = text;
                                        });
                                      },
                                    ),

                                    // TextField(),
                                    ElevatedButton(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        if (_addressC.text.trim().isEmpty ||
                                            _addressC.text.trim().isEmpty) {
                                          return null;
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .update({'address': _newAdd});
                                        }
                                        _addressC.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text('Submit'),
                                    ),
                                    SizedBox(
                                      height: kBottomNavigationBarHeight,
                                    )
                                  ],
                                ))).whenComplete(() {
                          _addressC.clear();
                        });
                      },
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          address == "" ? "+ Add address" : address,
                          style: TextStyle(color: kPrimaryColor),
                          textAlign: TextAlign.right,
                        ),
                      ),
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
