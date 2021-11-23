import 'package:flavor_fog/screens/myshop/components/desc.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';

import 'shop_pic.dart';

class Body extends StatelessWidget {
  Body({required this.shopId});
  final String shopId;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(50)),
        child: Column(children: [
          Center(child: MyShopPic()),
          SizedBox(height: 50),
          DescScreen(
            shopId: shopId,
          ),
        ]));
  }
}
