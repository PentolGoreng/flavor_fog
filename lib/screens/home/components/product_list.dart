import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/components/product_card1.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/components/shop_card.dart';
import 'package:flavor_fog/models/product.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flavor_fog/components/listProduct.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class ProductList extends StatefulWidget {
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  late int currentPage;
  final PageController controller = PageController();
  List<Widget> _buildScreens() {
    return [
     ListProduct(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        
        
      ),];}
  @override
  Widget build(BuildContext context) {
    updateKeepAlive();
    return Expanded(
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //         onTap: () async {
          //           updateKeepAlive();
          //           controller.animateToPage(0,
          //               duration: defaultDuration, curve: Curves.linear);
          //         },
          //         child: Container(
          //           decoration: BoxDecoration(),
          //           height: 25,
          //           color: login_bg,
          //           width: MediaQuery.of(context).size.width * 0.5,
          //           child: Center(child: Text("Products")),
          //         )),
          //     GestureDetector(
          //       onTap: () async {
          //         updateKeepAlive();
          //         controller.animateToPage(1,
          //             duration: defaultDuration, curve: Curves.linear);
          //       },
          //       child: Container(
          //         height: 25,
          //         color: login_bg,
          //         width: MediaQuery.of(context).size.width * 0.5,
          //         child: Center(child: Text("Shops")),
          //       ),
          //     ),
          //   ],
          // ),
          
          PersistentTabView(context, screens: ),
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        // SizedBox(
                        //     height: getProportionateScreenHeight(
                        //         getProportionateScreenHeight(600)),
                        //     child:

                       
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

                        // SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    ),
                  ],
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

                // SizedBox(width: getProportionateScreenWidth(20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
