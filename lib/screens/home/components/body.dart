import 'package:flavor_fog/screens/home/components/product_list.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          const HomeHeader(),
          // SizedBox(height: getProportionateScreenWidth(10)),
          // const DiscountBanner(),
          // Categories(),
          // const SpecialOffers(),
          // SizedBox(height: getProportionateScreenWidth(30)),
          // PopularProducts(),
          SizedBox(height: getProportionateScreenWidth(5)),
          Expanded(child: ProductList(menuScreenContext: context)),
          SizedBox(height: getProportionateScreenWidth(30)),
        ],
      ),
    );
  }
}
