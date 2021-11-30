//@dart=2.9
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/models/product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
    this.product,
    this.id,
    this.title,
    this.description,
    this.images,
    this.colors,
    this.rating,
    this.price,
    this.isFavourite,
    this.isPopular,
  }) : super(key: key);
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;
  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(238),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    image: NetworkImage(widget.images[selectedImage]),
                  )
                  // child: Hero(
                  //   tag: widget.product.id.toString(),
                  //   child: ,
                  ),
            ),
          ],
        ),

        // SizedBox(
        //   child: CarouselSlider(
        //     items: widget.images.map((item) {
        //       return Builder(
        //         builder: (BuildContext context) {
        //           return Container(
        //               width: 400,
        //               height: 400,
        //               margin: EdgeInsets.all(0.5),
        //               // decoration:
        //               // BoxDecoration(color: Colors.lightBlue[100 * (i % 5)]),

        //               child: Image(image: NetworkImage(item)));
        //         },
        //       );
        //     }).toList(),
        //   ),
        // ),

        // ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.images.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        curve: Curves.ease,
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Color(0xFF212121),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image(
          image: NetworkImage(widget.images[index]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
