//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/components/persistent_widget_tab.dart';
import 'package:flavor_fog/screens/shop/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flavor_fog/models/product.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flavor_fog/routes.dart';
import '../constants.dart';
import '../size_config.dart';

class ShopCard extends StatelessWidget {
  const ShopCard(
      {Key key,
      this.width = 140,
      this.aspectRetio = 1.02,
      this.shopId,
      this.title,
      this.description,
      this.images,
      this.colors,
      this.rating,
      this.price,
      this.address,
      this.isFavourite,
      this.isPopular,
      this.product})
      : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final String shopId;
  final String title, description;
  final String images;
  final List<Color> colors;
  final double rating;
  final String address;
  final String price;
  final bool isFavourite, isPopular;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pushNewScreen(
        context,
        screen: ShopScreen(
          title: title,
          images: images,
          shopId: shopId,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: login_bg,
        height: 70,
        child: StreamBuilder<Object>(
            stream: FirebaseFirestore.instance
                .collection('shops')
                // .orderBy('sentAt', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final shopDB = snapshot.data.docs;
              return Padding(
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(20), bottom: 15, top: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(50),
                        width: getProportionateScreenHeight(50),
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Hero(
                              tag: '${shopId}'.toString(),
                              child: Image(
                                image: NetworkImage(images),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        title,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 2,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "IDR ${price}",
                      //       style: TextStyle(
                      //         fontSize: getProportionateScreenWidth(12),
                      //         fontWeight: FontWeight.w500,
                      //         color: kPrimaryColor,
                      //       ),
                      //     ),
                      //     // InkWell(
                      //     //   borderRadius: BorderRadius.circular(50),
                      //     //   onTap: () {},
                      //     //   child: Container(
                      //     //     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      //     //     height: getProportionateScreenWidth(28),
                      //     //     width: getProportionateScreenWidth(28),
                      //     //     decoration: BoxDecoration(
                      //     //       color: product.isFavourite
                      //     //           ? kPrimaryColor.withOpacity(0.15)
                      //     //           : kSecondaryColor.withOpacity(0.1),
                      //     //       shape: BoxShape.circle,
                      //     //     ),
                      //     //     child: SvgPicture.asset(
                      //     //       "assets/icons/Heart Icon_2.svg",
                      //     //       color: product.isFavourite
                      //     //           ? const Color(0xFFFF4848)
                      //     //           : const Color(0xFFDBDEE4),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
