import 'package:flavor_fog/components/rounded_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/components/default_button.dart';
import 'package:flavor_fog/models/product.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/services.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

@override
class _BodyState extends State<Body> {
  int items = 0;
  add() {
    setState(
      () => items++,
    );
  }

  minus() {
    setState(
      () => items--,
    );
  }

  TextEditingController item = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int selectedColor = 3;

    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Color(0xFF212121),
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFF212121),
                child: Column(
                  children: [
                    // ColorDots(product: widget.product),
                    TopRoundedContainer(
                      color: Color(0xFF212121),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () async {
                            item.text = '1';
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                height: getProportionateScreenHeight(250),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(20)),
                                child: Row(
                                  children: [
                                    ...List.generate(
                                      widget.product.colors.length,
                                      (index) => ColorDot(
                                        color: widget.product.colors[index],
                                        isSelected: index == selectedColor,
                                      ),
                                    ),
                                    Spacer(),
                                    RoundedIconBtn(
                                        icon: Icons.remove,
                                        press: () async {
                                          if (int.parse(item.text) > 0) {
                                            items--;
                                            setState(() {
                                              item.text = items.toString();
                                            });
                                          }
                                        }),
                                    SizedBox(
                                        width: getProportionateScreenWidth(10)),
                                    Container(
                                      width: getProportionateScreenWidth(20),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        // maxLength: 3,
                                        controller: item,
                                        enabled: false,
                                      ),
                                    ),
                                    SizedBox(
                                        width: getProportionateScreenWidth(10)),
                                    RoundedIconBtn(
                                        icon: Icons.add,
                                        showShadow: true,
                                        press: () {
                                          items++;
                                          setState(() {
                                            item.text = items.toString();
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            );
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
        SizedBox(
          height: kBottomNavigationBarHeight,
        )
      ],
    );
  }
}
