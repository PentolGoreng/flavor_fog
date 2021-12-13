import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/components/default_button.dart';
import 'package:flavor_fog/components/rounded_icon_btn.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/models/models.dart';
import 'package:flavor_fog/models/product.dart';
import 'package:flavor_fog/screens/shop/shop_screen.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flavor_fog/temprating.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Product product;
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;
  final String shop, shopId;

  Body(
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
      required this.isPopular,
      required this.shop,
      required this.shopId})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {

  String _item = '1';
  late String _token;
  int _item1 = 1;
  @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection('shops')
  //       .doc(widget.shopId)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     _token = documentSnapshot['token'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.shop);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('shops')
            .where('shopId', isEqualTo: widget.shopId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final shopDoc = snapshot.data.docs;
          print('${shopDoc[0]["image"]}');
          return ListView(
            children: [
              ProductImages(
                images: widget.images,
              ),
              TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDescription(
                      title: widget.title,
                      shop: widget.shop,
                      shopId: widget.shopId,
                      price: widget.price,
                      description: widget.description,
                      pressOnSeeMore: () {},
                    ),
                    SizedBox(
                      height: kBottomNavigationBarHeight * 1.5,
                    ),
                    GestureDetector(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: ShopScreen(
                            title: widget.shop,
                            images: shopDoc[0]['image'],
                            shopId: widget.shopId,
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${shopDoc[0]["image"]}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(height: 15),
                          Center(
                            child: Text(
                              shopDoc[0]['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TopRoundedContainer(
                      color: Color(0xFFF6F7F9),
                      child: Column(
                        children: [
                          // ColorDots(product: widget.product),
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
                                  color: kPrimaryColor,
                                  text: "Add To Cart",
                                  press: () {
                                    showModalBottomSheet(
                                      backgroundColor: Color(0xFF212121),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter
                                                  setState1 /*You can rename this!*/) {
                                            // setState1(() {
                                            //   _item = "1";
                                            // });
                                            return Container(
                                              height: 300,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          20),
                                                  vertical:
                                                      getProportionateScreenHeight(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      // ...List.generate(
                                                      //   product.colors.length,
                                                      //   (index) => ColorDot(
                                                      //     color: product.colors[index],
                                                      //     isSelected: index == selectedColor,
                                                      //   ),
                                                      // ),
                                                      Spacer(),
                                                      RoundedIconBtn(
                                                        icon: Icons.remove,
                                                        showShadow: true,
                                                        press: () {
                                                          _item1 == 1
                                                              ? null
                                                              : setState1(() {
                                                                  _item1--;
                                                                  _item = _item1
                                                                      .toString();
                                                                });
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  10)),
                                                      Text(_item),
                                                      SizedBox(
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  10)),
                                                      RoundedIconBtn(
                                                          icon: Icons.add,
                                                          showShadow: true,
                                                          press: () {
                                                            setState1(() {
                                                              _item1++;
                                                              _item = _item1
                                                                  .toString();
                                                            });
                                                          }),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  DefaultButton(
                                                      color: _item1 == 0
                                                          ? Colors.black
                                                          : kPrimaryColor,
                                                      text: _item1 == 0
                                                          ? "Remove"
                                                          : "Add To Cart",
                                                      press: () async {
                                                        final user =
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser;
                                                        final snapShot =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(user!.uid)
                                                                .collection(
                                                                    'cart')
                                                                .doc(widget
                                                                    .id) // varuId in your case
                                                                .get();

                                                        if (snapShot == null ||
                                                            !snapShot.exists) {
                                                          // Document with id == varuId doesn't exist.

                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(user.uid)
                                                              .collection(
                                                                  'cart')
                                                              .doc(widget.id)
                                                              .set({
                                                            'productId':
                                                                widget.id,
                                                            'shop': widget.shop,
                                                            'shopId':
                                                                widget.shopId,
                                                            'total': _item1,
                                                            'title':
                                                                widget.title,
                                                            'price':
                                                                widget.price,
                                                            'shopToken': _token,
                                                            'image': widget
                                                                .images[0]
                                                                .toString()
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        } else {
                                                          int itemCount =
                                                              snapShot['total'];
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'users')
                                                              .doc(user.uid)
                                                              .collection(
                                                                  'cart')
                                                              .doc(widget.id)
                                                              .update({
                                                            'total': _item1 +
                                                                itemCount,
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      }

                                                      // Navigator.pop(context);

                                                      // ? FirebaseFirestore
                                                      //     .instance
                                                      //     .collection('users')
                                                      //     .doc(user!.uid)
                                                      //     .update({
                                                      //     'cart': FieldValue
                                                      //         .arrayUnion([id]),
                                                      //   })
                                                      // : FirebaseFirestore
                                                      //     .instance
                                                      //     .collection('users')
                                                      //     .doc(user!.uid)
                                                      //     .update({
                                                      //     'cart': FieldValue
                                                      //         .arrayRemove(
                                                      //             [id]),
                                                      //   });
                                                      ),
                                                  // ElevatedButton(
                                                  //   onPressed: () {
                                                  //     pushNewScreen(context,
                                                  //         screen: tempRating(
                                                  //             id: widget.id),
                                                  //         pageTransitionAnimation:
                                                  //             PageTransitionAnimation
                                                  //                 .slideUp);
                                                  //   },
                                                  //   child: Text('rating'),
                                                  // ),
                                                  SizedBox(
                                                    height:
                                                        kBottomNavigationBarHeight *
                                                            2,
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                        // pushNewScreen(context,
                                        //     screen: tempRating(id: id),
                                        //     pageTransitionAnimation:
                                        //         PageTransitionAnimation.slideUp)
                                      },
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: kBottomNavigationBarHeight * 2,
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
