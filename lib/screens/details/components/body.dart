import 'package:flavor_fog/components/default_button.dart';
import 'package:flavor_fog/components/rounded_icon_btn.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/models/models.dart';
import 'package:flavor_fog/models/product.dart';
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
      required this.isPopular})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  String _item = '1';

  int _item1 = 1;

  @override
  Widget build(BuildContext context) {
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
                price: widget.price,
                description: widget.description,
                pressOnSeeMore: () {},
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
                            text: "Add To Cart",
                            press: () {
                              setState(() {
                                _item = '1';
                                _item1 = 1;
                              });
                              showModalBottomSheet(
                                backgroundColor: Color(0xFF212121),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
                                                getProportionateScreenWidth(20),
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
                                                    _item1 == 0
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
                                                        _item =
                                                            _item1.toString();
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
                                              press: () {},
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                pushNewScreen(context,
                                                    screen: tempRating(
                                                        id: widget.id),
                                                    pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .slideUp);
                                              },
                                              child: Text('rating'),
                                            ),
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
            ],
          ),
        ),
      ],
    );
  }
}
