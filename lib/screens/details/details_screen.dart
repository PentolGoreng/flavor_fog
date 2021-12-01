//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
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
  });
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;
  List<double> rateList = [];
  final String shop;

  double _rating1 = 0;

  @override
  @override
  Future<List<double>> getCordsFromFirebase() async {
    // print('Length of cords list is: ' + coordinatesList.length.toString()); //
    return rateList;
  }

  Widget build(BuildContext context) {
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .doc(id)
            .collection('rating')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List<double> ratings = [];
          snapshot.data.docs.forEach((element) {
            final map2 = element.data();
            ratings.add(map2['rating']);
          });
          double rating1 = (ratings.sum) / snapshot.data.docs.length;
          return Scaffold(
            backgroundColor: Color(0xFF212121),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(AppBar().preferredSize.height),
              child: CustomAppBar(rating: rating1),
            ),
            body: Body(
              title: title,
              price: price,
              description: description,
              images: images,
              id: id,
              shop: shop,
            ),
          );
        });
  }
}

// class ProductDetailsArguments {
//   final Product product;

//   ProductDetailsArguments({this.product});
// }
