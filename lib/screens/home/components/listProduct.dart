import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/components/product_card1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListShop extends StatelessWidget {
  const ListShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
    );
  }
}
