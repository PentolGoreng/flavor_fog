//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/screens/details/components/add.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';
import '../../models/product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;
  static String routeName = "/details";

  DetailsScreen({
    this.product,
    this.id,
    this.title,
    this.description,
    this.images,
    this.colors,
    this.rating,
    this.price,
    this.isFavourite,
    this.isPopular,
    this.shop,
    this.shopId,
  });
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;
  final String shop, shopId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<double> rateList = [];
  String shopOwner = "";
  double _rating1 = 0;

  @override
  @override
  Future<List<double>> getCordsFromFirebase() async {
    // print('Length of cords list is: ' + coordinatesList.length.toString()); //
    return rateList;
  }

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

  Future check() async {
    final shopDocCheck = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (shopOwner == "") {
        if (shopDocCheck.data().containsValue("hasShop")) {
          if (shopDocCheck.data().containsValue(widget.shopId)) {
            setState(() {
              shopOwner = 'YES';
            });
          } else {
            setState(() {
              shopOwner = 'NO';
            });
          }
        } else if (!shopDocCheck.data().containsValue("hasShop")) {
          setState(() {
            shopOwner = 'NO';
          });
        }
      }
      // if (documentSnapshot.exists) {
      //   print('Document data: ${documentSnapshot.data()}');
      //   String shopId = shopDoc["shopId"];

      //   try {
      //     dynamic nested =
      //         documentSnapshot.get(FieldPath(['shopId']));
      //   } on StateError catch (e) {
      //     print(e);
      //   }
      // } else {}
    });
  }

  List<File> image = [];
  inputimage() async {
    for (var i = 0; i < widget.images.length; i++) {
      image.add(await urlToFile(widget.images[i]));
    }
  }

  Widget build(BuildContext context) {
    check();

    final agrs = ModalRoute.of(context).settings.arguments;
//     print(widget.id);
//     var results = FirebaseFirestore.instance
//         .collection('products')
//         .doc(widget.id)
//         .collection('rating')
//         .snapshots();

// // // int _rating = 0;

//     Future getTotal(item) async {
//       rateList.add(double.parse(item));
//       rateList.forEach((element) => _rating1 += element);

//       print('LIST: $rateList');
//       print('SUM: $_rating1');
//       return _rating1;
//     }

//     double value = 0;
//     for (double element in rateList) {
//       setState(() {
//         value = value += element;
//       });
//     }

    // print(rateList[0]);
    // final ProductDetailsArguments agrs =
    //     ModalRoute.of(context).settings.arguments as ProductDetailsArguments;
    // return StreamBuilder(
    //     stream: FirebaseFirestore.instance
    //         .collection('products')
    //         .doc(widget.id)
    //         .collection('rating')
    //         .snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //       List<double> ratings = [];
    //       snapshot.data.docs.forEach((element) {
    //         final map2 = element.data();
    //         ratings.add(map2['rating']);
    //       });
    //       double rating1 = (ratings.sum) / snapshot.data.docs.length;
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: shopOwner == "YES"
            ? IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await inputimage();
                  await pushNewScreen(context,
                      screen: EditProduct(
                        shop: widget.shop,
                        shopId: widget.shopId,
                        id: widget.id,
                        images: widget.images,
                        image: image,
                        title: widget.title,
                        price: widget.price,
                        description: widget.description,
                      ));
                  image.clear();
                },
              )
            : Container(
                height: 40,
              ),
      ),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      //   child: CustomAppBar(rating: rating1),
      // ),
      body: Body(
        title: widget.title,
        price: widget.price,
        description: widget.description,
        images: widget.images,
        id: widget.id,
        shop: widget.shop,
        shopId: widget.shopId,
      ),
    );
  }
  // );
}
// }

// class ProductDetailsArguments {
//   final Product product;

//   ProductDetailsArguments({this.product});
// }
