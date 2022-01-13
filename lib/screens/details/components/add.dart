//@dart=2.9
// ignore_for_file: missing_required_param

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/screens/home/home_screen.dart';
import 'package:flavor_fog/screens/myshop/components/addPressed.dart';
import 'package:flavor_fog/screens/myshop/myshop_screen.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:transparent_image/transparent_image.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

// import 'package:path/path.dart';

class EditProduct extends StatefulWidget {
  final String shop;
  final String token;
  final String title, description, price;
  final String id;
  final String shopId;
  final List<String> images;
  final List<File> image;
  const EditProduct({
    Key key,
    this.shop,
    this.shopId,
    this.token,
    this.id,
    this.images,
    this.image,
    this.title,
    this.description,
    this.price,
  }) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<EditProduct> {
  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;

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
  List<File> image1 = [];
  // int intN = 1;
  DocumentReference docRef;
  // File widget.imageFile;
  // File widget.imageFile2;
  // File widget.imageFile3;
  // File widget.imageFile4;
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
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.id)
            .delete();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  // getData() async {
  //   final http.Response responseData = await http.get(strURL);
  //   uint8list = responseData.bodyBytes;
  //   var buffer = uint8list.buffer;
  //   ByteData byteData = ByteData.view(buffer);
  //   var tempDir = await getTemporaryDirectory();
  //   File file = await File('${tempDir.path}/img').writeAsBytes(
  //       buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  // }
  Future<File> urlToFile(String imageUrl) async {
    // generate random number.
    var rng = new Random(); // get temporary directory of device.
    Directory tempDir =
        await getTemporaryDirectory(); // get temporary path from temporary directory.
    String tempPath = tempDir
        .path; // create a new file in temporary path with random file name.
    File file = new File('$tempPath' +
        (rng.nextInt(100)).toString() +
        '.png'); // call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(
        Uri.parse(imageUrl)); // write bodyBytes received in response to file.
    await file.writeAsBytes(response
        .bodyBytes); // now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  setImages() async {
    for (var i = 0; i < widget.images.length; i++) {
      image1.add(await urlToFile(widget.images[i]));
    }
    ;
  }

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
                  Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        showAlertDialog(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: image1.length == 0
                            ? widget.image.length + 1
                            : image1.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          image1 = widget.image;
                          return index == 0
                              ? Center(
                                  child: image1.length > 3
                                      ? Container(
                                          height: 1,
                                          width: 1,
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: kPrimaryColor,
                                          ),
                                          onPressed: () => !uploading
                                              ? chooseImage()
                                              : null),
                                )
                              : Stack(clipBehavior: Clip.none, children: [
                                  Container(
                                    margin: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(image1[index - 1]),
                                            fit: BoxFit.cover)),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        // FirebaseStorage.instance
                                        //     .refFromURL(widget.images[index])
                                        //     .delete();
                                        // FirebaseFirestore.instance
                                        //     .collection('products')
                                        //     .doc(widget.id)
                                        //     .update({
                                        //   'images':
                                        //       FieldValue.arrayRemove([index])
                                        // });

                                        setState(() {
                                          image1 = widget.image;
                                          image1.removeAt(index - 1);
                                          print(image1.length);
                                        });
                                      },
                                      child: Positioned(
                                        top: -3,
                                        right: 0,
                                        child: Container(
                                          height:
                                              getProportionateScreenWidth(16),
                                          width:
                                              getProportionateScreenWidth(16),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFF4848),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.white),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        10),
                                                height: 1,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                ]);
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
                      uploadFile();
                      // FocusScope.of(context).unfocus();
                      // if (_titleController.text.trim().isEmpty ||
                      //     _priceController.text.trim().isEmpty) {
                      //   return null;
                      // } else {
                      //   // widget.imageFile == null ? null : submitimg1();
                      //   // widget.imageFile2 == null ? null : submitimg2();
                      //   // widget.imageFile3 == null ? null : submitimg3();
                      //   // widget.imageFile4 == null ? null : submitimg4();
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
      image1.add(File(pickedFile?.path));
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
        image1.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    print(image1.length);

    for (var ind1 = 0; ind1 < widget.images.length; ind1++) {
      FirebaseStorage.instance.refFromURL(widget.images[ind1]).delete();

      FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .update({'images': FieldValue.arrayRemove(widget.images)});
    }
    int i = 1;

    FocusScope.of(context).unfocus();
    if (_titleController.text.trim().isEmpty ||
        _priceController.text.trim().isEmpty ||
        image1.length == 0) {
      return null;
    } else {
      // widget.imageFile == null ? null : submitimg1();
      // widget.imageFile2 == null ? null : submitimg2();
      // widget.imageFile3 == null ? null : submitimg3();
      // widget.imageFile4 == null ? null : submitimg4();
      // var img in widget.image
      for (var ind = 0; ind < image1.length; ind++) {
        setState(() {
          val = i / image1.length;
        });
        ref = firebase_storage.FirebaseStorage.instance.ref().child(
            'images/${widget.shop}/${_titleController.text}/${Path.basename(image1[ind].path)}');
        await ref.putFile(image1[ind]).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            urls.add(value);
            i++;
          });
        });
      }
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .update({
        'images': urls.isEmpty
            ? FieldValue.arrayUnion(imageNames)
            : FieldValue.arrayUnion(urls),
        'title': _titleController.text,
        'price': _priceController.text,
        'desc': _descController.text,
      });
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
    _titleController = TextEditingController(text: widget.title);
    _priceController = TextEditingController(text: widget.price);
    _descController = TextEditingController(text: widget.description);
  }
}
