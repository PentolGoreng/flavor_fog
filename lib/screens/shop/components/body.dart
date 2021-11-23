import 'package:flavor_fog/screens/shop/components/desc.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';

import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(50)),
        child: Column(children: [
          Center(child: ShopPic()),
          SizedBox(height: 50),
          DescScreen(),
        ]));
  }
}
