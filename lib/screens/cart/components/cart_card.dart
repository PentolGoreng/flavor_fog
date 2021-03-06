//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/models/cart.dart';
import 'package:intl/intl.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  CartCard({
    Key key,
    // required this.cart,
    this.id,
    this.item,
    this.images,
    this.title,
    this.price,
    this.color,
  }) : super(key: key);
  final String images;
  final Color color;
  final String id, title, price;
  final int item;
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  // final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: login_bg,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image(image: NetworkImage(images.toString())),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "Rp ${oCcy.format(int.parse(price))}",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                children: [
                  TextSpan(
                    text: "      x${item}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
