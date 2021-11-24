import 'package:flavor_fog/components/default_button.dart';
import 'package:flavor_fog/models/models.dart';
import 'package:flavor_fog/models/product.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flavor_fog/temprating.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:shop_app/components/default_button.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;

  const Body(
      {Key? key,
      required this.product,
      required this.id,
      required this.title,
      required this.description,
      required this.images,
      required this.colors,
      required this.rating,
      required this.price,
      required this.isFavourite,
      required this.isPopular})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(
          images: images,
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                title: title,
                price: price,
                description: description,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    // ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () => {
                            pushNewScreen(context,
                                screen: tempRating(id: id),
                                pageTransitionAnimation:
                                    PageTransitionAnimation.slideUp)
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
