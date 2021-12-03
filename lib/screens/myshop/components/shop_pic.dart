//@dart=2.9

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class MyShopPic extends StatefulWidget {
  String shopId;
  MyShopPic({Key key, this.shopId}) : super(key: key);

  @override
  State<MyShopPic> createState() => _MyShopPicState();
}

class _MyShopPicState extends State<MyShopPic>
    with SingleTickerProviderStateMixin {
  bool _isSelected = true;
  declareCam() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    pickedFile == null
        ? null
        : setState(() {
            _imageFile = File(pickedFile.path);
          });

    String fileName = basename(_imageFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('uploads/$fileName');
    UploadTask uploadTask = ref.putFile(_imageFile);
    return uploadTask;
  }

  declareGal() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    pickedFile == null
        ? null
        : setState(() {
            _imageFile = File(pickedFile.path);
          });

    String fileName = basename(_imageFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('uploads/$fileName');
    UploadTask uploadTask = ref.putFile(_imageFile);
    return uploadTask;
  }

  AnimationController _animationController;
  void updateView() {
    setState(() {
      _isSelected = !_isSelected;
    });
    _isSelected
        ? _animationController.reverse()
        : _animationController.forward();
  }

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
  }

  File _imageFile;
  final _picker = ImagePicker();
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print(widget.shopId);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('shops')
          .doc('${widget.shopId}')
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
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      primary: Colors.white,
                      backgroundColor: Color(0xFFF5F6F9),
                    ),
                    onPressed: () async {
                      final pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile == null) {
                      } else {
                        setState(() {
                          _imageFile = File(pickedFile.path);
                        });
                        String fileName = basename(_imageFile.path);
                        FirebaseStorage storage = FirebaseStorage.instance;
                        Reference ref =
                            storage.ref().child('uploads/$fileName');
                        UploadTask uploadTask = ref.putFile(_imageFile);
                        uploadTask.then((res) {
                          res.ref.getDownloadURL().then((res) =>
                              FirebaseFirestore.instance
                                  .collection('shops')
                                  .doc(widget.shopId)
                                  .update({'image': res}));
                        });
                      }
                    },
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                  ),
                ),
              ),
              // AnimatedPositioned(
              //   duration: defaultDuration,
              //   right: _isSelected ? -16 : -25,
              //   bottom: _isSelected ? 0 : -60,
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
              //       onPressed: () async {
              //         if (_isSelected) {
              //         } else {
              //           final pickedFile =
              //               await _picker.pickImage(source: ImageSource.camera);
              //           pickedFile == null
              //               ? null
              //               : setState(() {
              //                   _imageFile = File(pickedFile.path);
              //                 });

              //           String fileName = basename(_imageFile.path);
              //           FirebaseStorage storage = FirebaseStorage.instance;
              //           Reference ref =
              //               storage.ref().child('uploads/$fileName');
              //           UploadTask uploadTask = ref.putFile(_imageFile);
              //           uploadTask.then((res) {
              //             res.ref.getDownloadURL().then((res) =>
              //                 FirebaseFirestore.instance
              //                     .collection('shops')
              //                     .doc(widget.shopId)
              //                     .update({'image': res}));
              //           });
              //         }
              //       },
              //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              //     ),
              //   ),
              // ),
              // AnimatedPositioned(
              //   duration: defaultDuration,
              //   right: _isSelected ? -16 : -78,
              //   bottom: _isSelected ? 0 : -10,
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
              //       onPressed: () async {
              //         if (_isSelected) {
              //           final pickedFile = await _picker.pickImage(
              //               source: ImageSource.gallery);
              //           pickedFile == ""
              //               ? null
              //               : setState(() {
              //                   _imageFile = File(pickedFile.path);
              //                 });
              //           String fileName = basename(_imageFile.path);
              //           FirebaseStorage storage = FirebaseStorage.instance;
              //           Reference ref =
              //               storage.ref().child('uploads/$fileName');
              //           UploadTask uploadTask = ref.putFile(_imageFile);
              //           uploadTask.then((res) {
              //             res.ref.getDownloadURL().then((res) =>
              //                 FirebaseFirestore.instance
              //                     .collection('shops')
              //                     .doc(widget.shopId)
              //                     .update({'image': res}));
              //           });
              //         } else {
              //           updateView();
              //         }
              //       },
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
