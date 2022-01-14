//@dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/screens/myshop/components/addPressed.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

// import 'package:path/path.dart';

class AddProduct extends StatefulWidget {
  final String shop;
  final String token;
  final String shopId;
  const AddProduct({Key key, this.shop, this.shopId, this.token})
      : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;
  bool still = false;
  List<File> _image = [];
  final picker = ImagePicker();
  final _picker = ImagePicker();
  TextEditingController _titleController = TextEditingController();

  TextEditingController _descController = TextEditingController();

  TextEditingController _priceController = TextEditingController();
  List<File> imageList = [];
  List<String> imageNames = [
    "https://firebasestorage.googleapis.com/v0/b/flavour-fog.appspot.com/o/images%2Fno-image-icon-23492.png?alt=media&token=625bbeb7-3269-4e87-85ee-a2f2654c0f03"
  ];
  List<String> urls = [];

  // int intN = 1;
  DocumentReference docRef;
  // File _imageFile;
  // File _imageFile2;
  // File _imageFile3;
  // File _imageFile4;
  // Future handleUploadImage() async {
  //   var firebaseUser = await FirebaseAuth.instance.currentUser;

  //   try {
  //     for (int i = 0; i < imageList.length; i++) {
  //       FirebaseStorage storage = FirebaseStorage.instance;
  //       Reference ref = storage
  //           .ref()
  //           .child('${widget.shop}/${_titleController.text}/${imageNames[i]}');
  //       UploadTask uploadTask = ref.putFile(imageList[i]);
  //       await uploadTask.then((res) async {
  //         await res.ref.getDownloadURL().then((res) async {
  //           await urls.add(res);
  //         });
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: getProportionateScreenHeight(600),
        color: login_bg,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        itemCount: _image.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Center(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: kPrimaryColor,
                                      ),
                                      onPressed: () =>
                                          !uploading ? chooseImage() : null),
                                )
                              : Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(_image[index - 1]),
                                          fit: BoxFit.cover)),
                                );
                        }),
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Product Name"),
                    maxLength: 20,
                    controller: _titleController,
                    onChanged: (text) {
                      // setState(() {
                      //   _newShop = text;
                      // });
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Price"),
                    // maxLines: 5,
                    maxLength: 12,
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (text) {
                      // setState(() {
                      //   _newShop1 = text;
                      // });
                    },
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: TextField(
                      decoration: InputDecoration(hintText: "Description"),
                      maxLines: null,
                      maxLength: 500,
                      controller: _descController,
                      onChanged: (text) {
                        // setState(() {
                        //   _newShop1 = text;
                        // });
                      },
                    ),
                  ),
                  // TextField(),
                  ElevatedButton(
                    onPressed: () async {
                      if (still == false) {
                        setState(() {
                          still = true;
                        });
                        uploadFile();
                      }
                      // FocusScope.of(context).unfocus();
                      // if (_titleController.text.trim().isEmpty ||
                      //     _priceController.text.trim().isEmpty) {
                      //   return null;
                      // } else {
                      //   // _imageFile == null ? null : submitimg1();
                      //   // _imageFile2 == null ? null : submitimg2();
                      //   // _imageFile3 == null ? null : submitimg3();
                      //   // _imageFile4 == null ? null : submitimg4();
                      //   await handleUploadImage();

                      //   docRef = await FirebaseFirestore.instance
                      //       .collection('products')
                      //       .add({
                      //     'images': FieldValue.arrayUnion(urls),
                      //     'title': _titleController.text,
                      //     'price': _priceController.text,
                      //     'desc': _descController.text,
                      //     'shopId': widget.shopId,
                      //     'shop': widget.shop,
                      //   });
                      //   FirebaseFirestore.instance
                      //       .collection('products')
                      //       .doc(docRef.id)
                      //       .update({
                      //     'id': docRef.id,
                      //     'images': FieldValue.arrayUnion(urls),
                      //   });
                      // }
                      // Navigator.pop(context);
                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(
                    height: kBottomNavigationBarHeight,
                  )
                ],
              ),
            ),
            uploading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          'uploading...',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        value: val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ))
                : Container(),
          ],
        ));
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

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

  Future uploadFile() async {
    int i = 1;

    FocusScope.of(context).unfocus();
    if (_titleController.text.trim().isEmpty ||
        _priceController.text.trim().isEmpty) {
      return null;
    } else {
      // _imageFile == null ? null : submitimg1();
      // _imageFile2 == null ? null : submitimg2();
      // _imageFile3 == null ? null : submitimg3();
      // _imageFile4 == null ? null : submitimg4();
      for (var img in _image) {
        setState(() {
          val = i / _image.length;
        });
        ref = firebase_storage.FirebaseStorage.instance.ref().child(
            'images/${widget.shop}/${_titleController.text}/${Path.basename(img.path)}');
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            urls.add(value);
            i++;
          });
        });
      }
      docRef = await FirebaseFirestore.instance.collection('products').add({
        'images': urls.isEmpty
            ? FieldValue.arrayUnion(imageNames)
            : FieldValue.arrayUnion(urls),
        'title': _titleController.text,
        'price': _priceController.text,
        'desc': _descController.text,
        'shopId': widget.shopId,
        'shop': widget.shop,
        'shopToken': widget.token,
      });
      FirebaseFirestore.instance.collection('products').doc(docRef.id).update({
        'id': docRef.id,
        // 'images': FieldValue.arrayUnion(urls),
      });
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }
}
