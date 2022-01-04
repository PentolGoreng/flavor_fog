//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flavor_fog/screens/cart/cart_screen.dart';
import 'package:flavor_fog/screens/home/components/icon_btn_with_counter.dart';
import 'package:flavor_fog/screens/myshop/components/requests.dart';
import 'package:flutter/foundation.dart';
//@dart=2.9
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:flavor_fog/components/product_card1.dart';
import 'package:flavor_fog/components/shop_card.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/models/product.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flavor_fog/screens/home/components/listProduct.dart';
import 'package:flavor_fog/screens/home/components/listShop.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class ProductList extends StatefulWidget {
  final Function callback;

  final BuildContext menuScreenContext;

  const ProductList({
    Key key,
    this.callback,
    this.menuScreenContext,
  });
  static String routeName = "/list";
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with AutomaticKeepAliveClientMixin {
  String search = "";
  int currentPage;
  final PageController controller = PageController();
  Map<String, dynamic> _list;
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    updateKeepAlive();
    // Widget _list(DocumentSnapshot data) {
    //   return ProductCard1(
    //       title: data['title'],
    //       price: data['price'],
    //       id: data['id'],
    //       images: List.from(data['images']),
    //       description: data['desc'],
    //       shop: data['shop'],
    //       shopId: data['shopId']);
    // }

    return Container(
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.7,
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    onSubmitted: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Search product",
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
                IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  press: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CartScreen();
                        },
                      ),
                    );
                  },
                ),
                // IconBtnWithCounter(
                //   svgSrc: "assets/icons/Bell.svg",
                //   numOfitem: 3,
                //   press: () {},
                // ),
              ],
            ),
          ),
          DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Container(
                height: 500,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: AppBar(
                      backgroundColor: login_bg,
                      flexibleSpace: TabBar(
                        indicatorColor: kPrimaryColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        // indicator: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(50), // Creates border
                        //     color: kPrimaryColor),
                        tabs: [
                          Tab(
                            child: Text('Products'),
                          ),
                          Tab(
                            child: Text('Shops'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('products')
                              // .orderBy('sentAt', descending: true)
                              .snapshots()

                          // .orderBy('sentAt', descending: true)
                          ,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final productDB = snapshot.data.docs;
                            final productFilter = snapshot.data.docs
                                .where((DocumentSnapshot<Object> element) =>
                                    element['title']
                                        .toString()
                                        .toLowerCase()
                                        .contains(search.toLowerCase()))
                                .toList();

                            return GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              children: [
                                // snapshot.data.docs
                                //     .where((DocumentSnapshot<Object> element) =>
                                //         element['title']
                                //             .toString()
                                //             .toLowerCase()
                                //             .contains(search.toLowerCase()))
                                //     .map(_list)
                                //     .toList()
                                ...List.generate(
                                  search == "" || search == null
                                      ? snapshot.data.docs.length
                                      : productFilter.length,
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
                                    return search == "" || search == null
                                        ? ProductCard1(
                                            title: productDB[index]['title'],
                                            price: productDB[index]['price'],
                                            id: productDB[index]['id'],
                                            images: List.from(
                                                productDB[index]['images']),
                                            description: productDB[index]
                                                ['desc'],
                                            shop: productDB[index]['shop'],
                                            shopId: productDB[index]['shopId'])
                                        : ProductCard1(
                                            title: productFilter[index]
                                                ['title'],
                                            price: productFilter[index]
                                                ['price'],
                                            id: productFilter[index]['id'],
                                            images: List.from(
                                                productFilter[index]['images']),
                                            description: productFilter[index]
                                                ['desc'],
                                            shop: productFilter[index]['shop'],
                                            shopId: productFilter[index]
                                                ['shopId']);
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
                              ],
                            );

                            // MessageBubble(
                            //     message: chatDocuments[index]['text'],
                            //     isMe: chatDocuments[index]['userId'] ==
                            //         futureSnapshot.data.uid,
                            //     key: ValueKey(chatDocuments[index].id),
                            //     firstName: chatDocuments[index]['name'],
                            //     imageUrl: chatDocuments[index]['image'],
                            //   )
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('shops')
                              // .orderBy('sentAt', descending: true)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final shopDB = snapshot.data.docs;

                            return ListView(
                              shrinkWrap: true,
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
                                    return ShopCard(
                                      title: shopDB[index]['title'],
                                      shopId: shopDB[index]['shopId'],
                                      images: shopDB[index]['image'],
                                      address: shopDB[index]['address'],
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
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
