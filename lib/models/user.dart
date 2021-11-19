//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flavour_fog/models/cart_item.dart';

class User {
  static const UID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";
  static const IMAGE = "image";

  String uid;
  String name;
  String email;

  String image;
  // List<CartItemModel> cart;

  User({this.uid, this.name, this.email, this.image});

  User.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot[NAME];
    email = snapshot[EMAIL];
    uid = snapshot[UID];
    image = snapshot[IMAGE];
    // cart = _convertCartItems(snapshot[CART] ?? []);
  }
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      uid: (doc.data() as dynamic)['id'],
      email: (doc.data() as dynamic)['email'],
      name: (doc.data() as dynamic)['name'],
      image: (doc.data() as dynamic)['image'],
      // username: doc['username'],
      // photoUrl: doc['photoUrl'],
      // displayName: doc['displayName'],
      // bio: doc['bio'],
      // fullNames: doc['fullNames'],
      // practice: doc['practice'],
      // speciality: doc['speciality'],
      // phone: doc['phone'],
      // mobile: doc['mobile'],
      // emergency: doc['emergency'],
      // address: doc['address'],
      // city: doc['city'],
      // location: doc['location'],
    );
  }
  // List<CartItemModel> _convertCartItems(List cartFomDb) {
  //   List<CartItemModel> _result = [];
  //   if (cartFomDb.length > 0) {
  //     cartFomDb.forEach((element) {
  //       _result.add(CartItemModel.fromMap(element));
  //     });
  //   }
  //   return _result;
  // }

  // List cartItemsToJson() => cart.map((item) => item.toJson()).toList();
}
