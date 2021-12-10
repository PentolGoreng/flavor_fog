//@dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/screens/home/components/icon_btn_with_counter.dart';
import 'package:flavor_fog/screens/myshop/components/add.dart';
import 'package:flavor_fog/screens/myshop/components/addPressed.dart';
import 'package:flavor_fog/screens/myshop/components/desc.dart';
import 'package:flavor_fog/screens/myshop/components/myshop_list.dart';
import 'package:flavor_fog/screens/myshop/components/requests.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

import 'shop_pic.dart';

class Body extends StatefulWidget {
  Body({this.shopId, this.token});
  final String shopId;
  final String token;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _descController = TextEditingController();

  TextEditingController _priceController = TextEditingController();
  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  final picker = ImagePicker();

  List<File> _image = [];
  @override

  // Future<Null> _uploadImages() async {
  //   imageList.map((f) {
  //     String fileName = basename(f.path);
  //     FirebaseStorage storage = FirebaseStorage.instance;
  //     Reference ref = storage.ref().child('uploads/$fileName');
  //     UploadTask uploadTask = ref.putFile(f);
  //     uploadTask.then((res) {
  //       res.ref.getDownloadURL().then((res) => urls.add(res));
  //       return res;
  //     });
  //   });
  //   return imageList;
  // }
  // submitimg1() {
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child('uploads/$_imageFile');
  //   UploadTask uploadTask = ref.putFile(_imageFile);
  //   uploadTask.then((res) {
  //     res.ref.getDownloadURL().then((res) => urls[0] = res.toString());
  //   });
  // }

  // submitimg2() {
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child('uploads/$_imageFile2');
  //   UploadTask uploadTask = ref.putFile(_imageFile2);
  //   uploadTask.then((res) {
  //     res.ref.getDownloadURL().then((res) => urls[1] = res.toString());
  //   });
  // }

  // submitimg3() {
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child('uploads/$_imageFile2');
  //   UploadTask uploadTask = ref.putFile(_imageFile2);
  //   uploadTask.then((res) {
  //     res.ref.getDownloadURL().then((res) => urls[2] = res.toString());
  //   });
  // }

  // submitimg4() {
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child('uploads/$_imageFile3');
  //   UploadTask uploadTask = ref.putFile(_imageFile3);
  //   uploadTask.then((res) {
  //     res.ref.getDownloadURL().then((res) => urls[3] = res.toString());
  //   });
  // }

  final user = FirebaseAuth.instance.currentUser;

  String _shop;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('shops')
            .where('shopId', isEqualTo: widget.shopId)
            .snapshots(),
        builder: (context, snapshot) {
          final dataShop = snapshot.data.docs;
          _shop = dataShop[0]['title'];
          return Scaffold(
              body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(50)),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconBtnWithCounter(
                          svgSrc: "assets/icons/Bell.svg",
                          numOfitem: 3,
                          press: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Requests(
                                    shopId: widget.shopId,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Center(child: MyShopPic(shopId: widget.shopId)),
                    SizedBox(height: 50),
                    DescScreen(
                      shopId: widget.shopId,
                    ),
                    MyShopList(shopId: widget.shopId),
                    SizedBox(
                      height: kBottomNavigationBarHeight,
                    )
                  ])),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  pushNewScreen(context,
                      screen: AddProduct(
                        token: widget.token,
                        shop: _shop,
                        shopId: widget.shopId,
                      ));
                  // _showDialog(context);
                },
                child: Icon(
                  Icons.add,
                ),
              ),
              bottomSheet: SizedBox(
                height: kBottomNavigationBarHeight * 2,
              ));
        });
  }

  // void _showDialog(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (BuildContext context,
  //             StateSetter setState1 /*You can rename this!*/) {
  //           return Flexible(
  //             child: ListView(
  //               shrinkWrap: true,
  //               scrollDirection: Axis.vertical,
  //               children: [
  //                 Container(
  //                   height: getProportionateScreenHeight(500),
  //                   child: Stack(
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.all(4),
  //                         child: GridView.builder(
  //                             itemCount: _image.length + 1,
  //                             gridDelegate:
  //                                 SliverGridDelegateWithFixedCrossAxisCount(
  //                                     crossAxisCount: 3),
  //                             itemBuilder: (context, index) {
  //                               return index == 0
  //                                   ? Center(
  //                                       child: IconButton(
  //                                           icon: Icon(
  //                                             Icons.add,
  //                                             color: kPrimaryColor,
  //                                           ),
  //                                           onPressed: () => !uploading
  //                                               ? chooseImage()
  //                                               : null),
  //                                     )
  //                                   : Container(
  //                                       margin: EdgeInsets.all(3),
  //                                       decoration: BoxDecoration(
  //                                           image: DecorationImage(
  //                                               image: FileImage(
  //                                                   _image[index - 1]),
  //                                               fit: BoxFit.cover)),
  //                                     );
  //                             }),
  //                       ),
  //                       uploading
  //                           ? Center(
  //                               child: Column(
  //                               mainAxisSize: MainAxisSize.min,
  //                               children: [
  //                                 Container(
  //                                   child: Text(
  //                                     'uploading...',
  //                                     style: TextStyle(fontSize: 20),
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 10,
  //                                 ),
  //                                 CircularProgressIndicator(
  //                                   value: val,
  //                                   valueColor: AlwaysStoppedAnimation<Color>(
  //                                       Colors.green),
  //                                 )
  //                               ],
  //                             ))
  //                           : Container(),
  //                     ],
  //                   ),
  //                 ),
  //                 TextField(
  //                   decoration: InputDecoration(hintText: "Product Name"),
  //                   maxLength: 20,
  //                   controller: _titleController,
  //                   onChanged: (text) {
  //                     // setState(() {
  //                     //   _newShop = text;
  //                     // });
  //                   },
  //                 ),
  //                 TextField(
  //                   decoration: InputDecoration(hintText: "Price"),
  //                   // maxLines: 5,
  //                   maxLength: 12,
  //                   controller: _priceController,
  //                   keyboardType: TextInputType.number,
  //                   inputFormatters: <TextInputFormatter>[
  //                     FilteringTextInputFormatter.digitsOnly
  //                   ],
  //                   onChanged: (text) {
  //                     // setState(() {
  //                     //   _newShop1 = text;
  //                     // });
  //                   },
  //                 ),
  //                 Container(
  //                   constraints: BoxConstraints(maxHeight: 200),
  //                   child: TextField(
  //                     decoration: InputDecoration(hintText: "Description"),
  //                     maxLines: null,
  //                     maxLength: 500,
  //                     controller: _descController,
  //                     onChanged: (text) {
  //                       // setState(() {
  //                       //   _newShop1 = text;
  //                       // });
  //                     },
  //                   ),
  //                 ),
  //                 // TextField(),
  //                 ElevatedButton(
  //                   onPressed: () async {
  //                     FocusScope.of(context).unfocus();
  //                     if (_titleController.text.trim().isEmpty ||
  //                         _priceController.text.trim().isEmpty) {
  //                       return null;
  //                     } else {
  //                       // _imageFile == null ? null : submitimg1();
  //                       // _imageFile2 == null ? null : submitimg2();
  //                       // _imageFile3 == null ? null : submitimg3();
  //                       // _imageFile4 == null ? null : submitimg4();
  //                       await handleUploadImage();

  //                       docRef = await FirebaseFirestore.instance
  //                           .collection('products')
  //                           .add({
  //                         'images': FieldValue.arrayUnion(urls),
  //                         'title': _titleController.text,
  //                         'price': _priceController.text,
  //                         'desc': _descController.text,
  //                         'shopId': widget.shopId,
  //                         'shop': widget.shop,
  //                       });
  //                       FirebaseFirestore.instance
  //                           .collection('products')
  //                           .doc(docRef.id)
  //                           .update({
  //                         'id': docRef.id,
  //                         'images': FieldValue.arrayUnion(urls),
  //                       });
  //                     }
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text('Submit'),
  //                 ),
  //                 SizedBox(
  //                   height: kBottomNavigationBarHeight,
  //                 )
  //               ],
  //             ),
  //           );
  //         });
  //       });
  // }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
          i++;
        });
      });
    }
  }
}
