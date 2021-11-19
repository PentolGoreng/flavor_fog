import 'package:flavor_fog/components/product_card1.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/components/product_card.dart';
import 'package:flavor_fog/models/product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Categories", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(300),
              child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  children: [
                    ...List.generate(
                      products.length,
                      (index) {
                        return ProductCard1(product: products[index]);

                        return SizedBox
                            .shrink(); // here by default width and height is 0
                      },
                    ),
                  ]),
            ),
            // SizedBox(width: getProportionateScreenWidth(20)),
          ],
        ),
      ],
    );
  }
}
