//@dart=2.9

import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating;
  final String price;
  final bool isFavourite, isPopular;

  Product({
    this.id,
    this.images,
    this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    this.title,
    this.price,
    this.description,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: '1',
    images: [
      "assets/images/liq2.jpg",
      "assets/images/liq3.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
    ],
    title: "Paket Liquid 1",
    price: '150000',
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: '2',
    images: [
      "assets/images/mod3.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Voopoo Vinci X",
    price: '350000',
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: '3',
    images: [
      "assets/images/mod5.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Kuy Pod Mod",
    price: '250000',
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: ' 4',
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: '20.20',
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "The Vaporesso GEN X 220W TC Box MOD combines the aircraft-grade aluminum construction with CNC machining in a compact unit. And the Vaporesso GEN X comes with intelligent Axon chip inside, which offers new PULSE mode. The Pulse Mode will continuously give vapers a hit throughout the puff (every 0.02s) – not just from the initial fire. The Power ECO Mode makes longer battery life. The Smart TC Mode can provide an one-step temperature control with the automatic identification of tanks. Moreover, you can vape with manual settings in DIY Mode. Powered by dual 18650 batteries, the Vaporesso GEN X device can fire out max 220W output to bring you a powerful vaping";

List<Product> products = [
  Product(
    id: '1',
    images: [],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
    ],
    title: "",
    price: '',
    description: "",
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
];
//   Product(
//     id: 2,
//     images: [
//       "assets/images/mod4.jpg",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Vaporesso Gen X",
//     price: '650000',
//     description: description,
//     rating: 4.1,
//     isPopular: true,
//   ),
//   Product(
//     id: 3,
//     images: [
//       "assets/images/mod5.jpg",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Kuy Pod Mod",
//     price: '36.55',
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 4,
//     images: [
//       "assets/images/wireless headset.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Logitech Head",
//     price: '20.20',
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//   ),
// ];
