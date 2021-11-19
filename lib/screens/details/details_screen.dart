//@dart=2.9
import 'package:flutter/material.dart';

import '../../models/product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  static String routeName = "/details";

  const DetailsScreen({this.product});

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
      body: Body(product: product),
    );
  }
}

// class ProductDetailsArguments {
//   final Product product;

//   ProductDetailsArguments({this.product});
// }
