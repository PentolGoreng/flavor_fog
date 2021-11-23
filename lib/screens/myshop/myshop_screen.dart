import 'package:flavor_fog/screens/myshop/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyShopScreen extends StatelessWidget {
  const MyShopScreen({Key? key, required this.shopId}) : super(key: key);
  final String shopId;
  static String routeName = "/myshop";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      body: Body(
        shopId: shopId,
      ),
    );
  }
}
