import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/components/product_card1.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/components/shop_card.dart';
import 'package:flavor_fog/models/product.dart';

import '../../../size_config.dart';

class MyShopList extends StatefulWidget {
  final String shopId;
  MyShopList({required this.shopId});
  @override
  State<MyShopList> createState() => _MyShopListState();
}

class _MyShopListState extends State<MyShopList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenWidth(20)),
        Column(
          children: [
            // SizedBox(
            //     height: getProportionateScreenHeight(
            //         getProportionateScreenHeight(600)),
            //     child:

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('shopId', isEqualTo: '${widget.shopId}')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final productDB = snapshot.data.docs;

                return GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    ...List.generate(
                      snapshot.data.docs.length,
                      (index) {
                        // Product(
                        //     title: productDB[index]['title'],
                        //     price: productDB[index]['price'],
                        //     id: productDB[index]['id'],
                        //     images: List.from(productDB[index]['images']),
                        //     description: productDB[index]['desc']);
                        // DetailsScreen(
                        //     title: productDB[index]['title'],
                        //     price: productDB[index]['price'],
                        //     id: productDB[index]['id'],
                        //     images: List.from(productDB[index]['images']),
                        //     description: productDB[index]['desc']);
                        return ProductCard1(
                          title: productDB[index]['title'],
                          price: productDB[index]['price'],
                          id: productDB[index]['id'],
                          images: List.from(productDB[index]['images']),
                          description: productDB[index]['desc'],
                          shopId: widget.shopId,
                        );

                        return SizedBox
                            .shrink(); // here by default width and height is 0
                      },
                    ),
                    // MessageBubble(
                    //     message: chatDocuments[index]['text'],
                    //     isMe: chatDocuments[index]['userId'] ==
                    //         futureSnapshot.data.uid,
                    //     key: ValueKey(chatDocuments[index].id),
                    //     firstName: chatDocuments[index]['name'],
                    //     imageUrl: chatDocuments[index]['image'],
                    //   )
                    SizedBox(
                      height: kBottomNavigationBarHeight,
                    )
                  ],
                );
              },
            ),

            // ),
            // GridView.count(crossAxisCount: 2, mainAxisSpacing: 30, children: [
            //   ...List.generate(
            //     products.length,
            //     (index) {
            //       return ProductCard1(product: products[index]);

            //       return SizedBox
            //           .shrink(); // here by default width and height is 0
            //     },
            //   ),
            // ]),

            SizedBox(
              height: kBottomNavigationBarHeight,
            ),
          ],
        ),
      ],
    );
  }
}
