//@dart=2.9
import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  static String routeName = "/details";

  const DetailsScreen({
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
  });
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;
  @override
  Widget build(BuildContext context) {
    final agrs = ModalRoute.of(context).settings.arguments;
    // final ProductDetailsArguments agrs =
    //     ModalRoute.of(context).settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      //   child: CustomAppBar(rating: product.rating),
      // ),
      body: Body(
        title: title,
        price: price,
        description: description,
        images: images,
        id: id,
      ),
    );
  }
}

// class ProductDetailsArguments {
//   final Product product;

//   ProductDetailsArguments({this.product});
// }
