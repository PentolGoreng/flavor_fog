import 'package:flavor_fog/screens/shop/components/desc.dart';
import 'package:flavor_fog/screens/shop/components/shop_list.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';

import 'shop_pic.dart';

class Body extends StatelessWidget {
  Body({required this.shopId, required this.title, required this.images});
  final String shopId;
  final String title;
  final String images;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(50)),
        child: Column(children: [
          Center(child: ShopPic(images: images)),
          SizedBox(height: 50),
          DescScreen(
            shopId: shopId,
          ),
          ShopList(shopId: shopId),
        ]));
  }
}
