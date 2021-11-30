import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/components/product_card1.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flavor_fog/screens/home/components/listShop.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/components/shop_card.dart';
import 'package:flavor_fog/models/product.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flavor_fog/screens/home/components/listProduct.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class ProductList extends StatefulWidget {
  final BuildContext menuScreenContext;

  const ProductList({Key? key, required this.menuScreenContext})
      : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with AutomaticKeepAliveClientMixin {
  late int currentPage;
  final PageController controller = PageController();
  List<Widget> _buildScreens() {
    return [
      ListProduct(
        menuScreenContext: widget.menuScreenContext,
      ),
      ListShop(menuScreenContext: widget.menuScreenContext)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Products",
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.radio),
        title: ("Shops"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
        ),
      ),
    ];
  }

  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    updateKeepAlive();
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
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
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      // .orderBy('sentAt', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final productDB = snapshot.data.docs;

                    return GridView.count(
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
                                description: productDB[index]['desc']);

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
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('shops')
                      // .orderBy('sentAt', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
        ));
  }
}
