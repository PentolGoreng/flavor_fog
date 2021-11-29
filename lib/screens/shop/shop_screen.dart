import 'package:flavor_fog/screens/shop/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen(
      {Key? key,
      required this.shopId,
      required this.images,
      required this.title})
      : super(key: key);
  final String shopId;
  final String images;
  final String title;
  static String routeName = "/shop";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Body(
        shopId: shopId,
        title: title,
        images: images,
      ),
    );
  }
}
