//@dart=2.9
import 'package:flavor_fog/screens/checkout.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_fog/components/default_button.dart';
import 'package:flavor_fog/components/rounded_icon_btn.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flavor_fog/models/cart.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _uid = FirebaseAuth.instance.currentUser;
  _modal() {
    showModalBottomSheet(
        backgroundColor: Color(0xFF212121),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) {
          return Column(
            children: [
              TextField(),
              ElevatedButton(
                  onPressed: () {},
                  child: Container(
                    child: Text('Submit'),
                  ))
            ],
          );
        });
  }

  List<Map<String, dynamic>> select;
  String selected = "";
  int _item1 = 1;
  String _item = '1';
  String shopId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_uid.uid)
            .collection('cart')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final cartDB = snapshot.data.docs;

          if (cartDB.length == 0) {
            return Center(
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: Center(
                    child: Text(
                  "Don't have to pay for anythin'\n For an empty cart!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )),
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: GroupedListView<dynamic, String>(
                      elements: cartDB,
                      groupBy: (element) => element['shop'],
                      groupSeparatorBuilder: (String a) => ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          color: selected == a ? kPrimaryColor : login_bg,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(a),
                              Text(
                                selected == a ? "selected" : "",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ),
                      indexedItemBuilder:
                          (context, dynamic element, int index) =>
                              GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1),
                          child: Dismissible(
                            key: Key(cartDB[index]['productId'].toString()),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart)
                              // setState(() {
                              //   demoCarts.removeAt(index);
                              // });
                              {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_uid.uid)
                                    .collection('cart')
                                    .doc(cartDB[index]['productId'])
                                    .delete();
                              } else {
                                // showModalBottomSheet(
                                //     backgroundColor: Color(0xFF212121),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(10.0),
                                //     ),
                                //     context: context,
                                //     builder: (context) {
                                //       return Padding(
                                //         padding: const EdgeInsets.all(20.0),
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceEvenly,
                                //           children: [
                                //             Text(
                                //               'Edit',
                                //               style: TextStyle(
                                //                   fontWeight: FontWeight.w600,
                                //                   fontSize: 20),
                                //             ),
                                //             TextField(),
                                //             ElevatedButton(
                                //                 onPressed: () {},
                                //                 child: Container(
                                //                   child: Text('Edit'),
                                //                 ))
                                //           ],
                                //         ),
                                //       );
                                //     });
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
                                                          _item =
                                                              _item1.toString();
                                                        });
                                                      }),
                                                ],
                                              ),
                                              Spacer(),
                                              DefaultButton(
                                                  color: kPrimaryColor,
                                                  text: "Edit",
                                                  press: () async {
                                                    final user = FirebaseAuth
                                                        .instance.currentUser;
                                                    final snapShot =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(_uid.uid)
                                                            .collection('cart')
                                                            .doc(cartDB[index]
                                                                ['productId'])
                                                            .update({
                                                      'total': _item1,
                                                    });
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
                              }
                            },
                            background: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Text('Edit'),
                                  Spacer(),
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Spacer(),
                                  SvgPicture.asset("assets/icons/Trash.svg"),
                                ],
                              ),
                            ),
                            child: CartCard(
                              color: cartDB[index]['shop'] == selected
                                  ? kPrimaryColor
                                  : login_bg,
                              id: cartDB[index]['productId'],
                              item: cartDB[index]['total'],
                              title: cartDB[index]['title'],
                              price: cartDB[index]['price'],
                              images: cartDB[index]['image'],
                            ),
                          ),
                        ),
                        onTap: () {
                          selected == "" || selected != cartDB[index]['shop']
                              ? setState(
                                  () {
                                    selected = cartDB[index]['shop'];
                                  },
                                )
                              : setState(
                                  () {
                                    selected = "";
                                  },
                                );
                          print(selected);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: kBottomNavigationBarHeight / 2,
                  child: Row(
                    children: [
                      Text(
                        'Swipe --> to Edit',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Swipe <-- to Delete',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
                GestureDetector(
                  child: SizedBox(
                    height: kBottomNavigationBarHeight,
                    child: Container(
                      color: kPrimaryColor,
                      child: Center(
                        child: Text('Proceed'),
                      ),
                    ),
                  ),
                  onTap: () {
                    selected == ""
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please select the shop for the transaction')))
                        : pushNewScreen(context,
                            screen: CheckOut(selected: selected));
                  },
                )
              ],
            );
          }
        });
  }
}
        
       
        // StreamBuilder(
        //     stream: FirebaseFirestore.instance
        //         .collection('shops')
        //         .where('shopId', isEqualTo: shopId)
        //         .snapshots(),
        //     builder: (BuildContext context, AsyncSnapshot snapshot) {
        //       final titleDB = snapshot.data.docs;
        //       return SizedBox(
        //         height: kBottomNavigationBarHeight / 4,
        //         child: Center(
        //           child: Text(titleDB['title']),
        //         ),
        //       );
        //     }),
        
     
  
