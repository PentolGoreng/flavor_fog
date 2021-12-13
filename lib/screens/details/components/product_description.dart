//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flavor_fog/models/product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    this.product,
    this.pressOnSeeMore,
    this.id,
    this.title,
    this.description,
    this.images,
    this.colors,
    this.rating,
    this.price,
    this.isFavourite,
    this.isPopular,
    this.shop,
    this.shopId,
  }) : super(key: key);
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;
  final Product product;
  final String shop;
  final String shopId;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Container(
        //     padding: EdgeInsets.all(getProportionateScreenWidth(15)),
        //     width: getProportionateScreenWidth(64),
        //     decoration: BoxDecoration(
        //       color:
        //           product.isFavourite ? Color(0xFF212121) : Color(0xFF212121),
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(20),
        //         bottomLeft: Radius.circular(20),
        //       ),
        //     ),
        //     child: SvgPicture.asset(
        //       "assets/icons/Heart Icon_2.svg",
        //       color:
        //           product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
        //       height: getProportionateScreenWidth(16),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: EdgeInsets.only(
        //     left: getProportionateScreenWidth(20),
        //     right: getProportionateScreenWidth(64),
        //   ),
        //   child: Text(
        //     product.description,
        //     maxLines: 3,
        //   ),
        // ),
        SizedBox(
          height: getProportionateScreenHeight(30),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(35)),
          child: ExpandableText(
            '${description}' + '\n',
            expandText: 'show more',
            collapseText: 'show less',
            // expanded: false,
            // textAlign: TextAlign.right,
            maxLines: 2,
            collapseOnTextTap: true,
            expandOnTextTap: true,
            linkColor: Colors.blue,
          ),
          // ),
          // Text(
          //   product.description,
          //   maxLines: 3,
        ),

        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: getProportionateScreenWidth(20),
        //     vertical: 10,
        //   ),
        //   child: GestureDetector(
        //     onTap: () {},
        //     child: Row(
        //       children: const [
        //         Text(
        //           "See More Detail",
        //           style: TextStyle(
        //               fontWeight: FontWeight.w600, color: kPrimaryColor),
        //         ),
        //         SizedBox(width: 5),
        //         Icon(
        //           Icons.arrow_forward_ios,
        //           size: 12,
        //           color: kPrimaryColor,
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
