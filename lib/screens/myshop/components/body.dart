import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/screens/myshop/components/desc.dart';
import 'package:flavor_fog/screens/myshop/components/myshop_list.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';

import 'shop_pic.dart';

class Body extends StatelessWidget {
  Body({required this.shopId});
  final String shopId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(50)),
          child: Column(children: [
            Center(child: MyShopPic(shopId: shopId)),
            SizedBox(height: 50),
            DescScreen(
              shopId: shopId,
            ),
            MyShopList(shopId: shopId),
          ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
      bottomSheet: SizedBox(
        height: kBottomNavigationBarHeight * 2,
      ),
    );
  }
}
