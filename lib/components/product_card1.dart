//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/components/persistent_widget_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flavor_fog/models/product.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flavor_fog/routes.dart';
import '../constants.dart';
import '../size_config.dart';

class ProductCard1 extends StatelessWidget {
  const ProductCard1(
      {Key key,
      this.width = 140,
      this.aspectRetio = 1.02,
      this.id,
      this.title,
      this.description,
      this.images,
      this.colors,
      this.rating,
      this.price,
      this.isFavourite,
      this.isPopular,
      this.product})
      : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('products')
            // .orderBy('sentAt', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final productDB = snapshot.data.docs;
          return Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
            child: SizedBox(
              width: getProportionateScreenWidth(width),
              child: GestureDetector(
                onTap: () => pushNewScreen(
                  context,
                  screen: DetailsScreen(
                    title: title,
                    images: images,
                    description: description,
                    price: price,
                    id: id,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Hero(
                          tag: '${id}'.toString() + "a",
                          child: Image(
                            image: NetworkImage(images[0]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "IDR ${price}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.w500,
                            color: kPrimaryColor,
                          ),
                        ),
                        // InkWell(
                        //   borderRadius: BorderRadius.circular(50),
                        //   onTap: () {},
                        //   child: Container(
                        //     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                        //     height: getProportionateScreenWidth(28),
                        //     width: getProportionateScreenWidth(28),
                        //     decoration: BoxDecoration(
                        //       color: product.isFavourite
                        //           ? kPrimaryColor.withOpacity(0.15)
                        //           : kSecondaryColor.withOpacity(0.1),
                        //       shape: BoxShape.circle,
                        //     ),
                        //     child: SvgPicture.asset(
                        //       "assets/icons/Heart Icon_2.svg",
                        //       color: product.isFavourite
                        //           ? const Color(0xFFFF4848)
                        //           : const Color(0xFFDBDEE4),
                        //     ),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
