import 'package:flavor_fog/screens/account/components/desc.dart';
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
          Center(child: ProfilePic()),
          SizedBox(height: 50),
          DescScreen(),
        ]));
  }
}
