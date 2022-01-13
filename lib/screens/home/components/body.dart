//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/screens/home/components/product_list.dart';
import 'package:flavor_fog/screens/myshop/components/requests.dart';
import 'package:flavor_fog/screens/myshop/myshop_screen.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flavor_fog/globals.dart' as globals;
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  String shopId;
  String name;
  checkshop() async {
    final shopDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (shopDoc.data().containsValue("hasShop")) {
        shopId = shopDoc['shopId'];
        name = shopDoc['name'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      // navigatorKey.currentState.pushNamed(Requests.routeName);
      await checkshop();
      // name = result.notification.additionalData['name'];

      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
      // print('${result.notification.additionalData['name']}');
      // print(shopId);

      globals.appNavigator.currentState.push(
          MaterialPageRoute(builder: (context) => Requests(shopId: shopId)));

      // print(
      //     'AAAAAAAAAAAAAAAAAAA\n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}');
      // this.setState(() {
      //   _debugLabelString =
      //       "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });
    return Container(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          // const HomeHeader(),
          // SizedBox(height: getProportionateScreenWidth(10)),
          // const DiscountBanner(),
          // Categories(),
          // const SpecialOffers(),
          // SizedBox(height: getProportionateScreenWidth(30)),
          // PopularProducts(),
          SizedBox(height: getProportionateScreenWidth(5)),
          Expanded(child: ProductList(menuScreenContext: context)),
          SizedBox(height: kBottomNavigationBarHeight),
        ],
      ),
    );
  }
}
