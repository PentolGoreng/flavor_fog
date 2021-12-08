// import 'dart:js';

// import 'dart:js';

import 'package:flavor_fog/components/rss_reader.dart';
import 'package:flavor_fog/screens/account/account_screen.dart';
import 'package:flavor_fog/screens/auth_screen.dart';
import 'package:flavor_fog/screens/chats/chats_screen.dart';
import 'package:flavor_fog/screens/forums.dart';
import 'package:flavor_fog/screens/home/components/product_list.dart';
import 'package:flavor_fog/screens/messages/message_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flavor_fog/screens/cart/cart_screen.dart';
import 'package:flavor_fog/screens/complete_profile/complete_profile_screen.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flavor_fog/screens/forgot_password/forgot_password_screen.dart';
import 'package:flavor_fog/screens/home/home_screen.dart';
import 'package:flavor_fog/screens/login_success/login_success_screen.dart';
import 'package:flavor_fog/screens/otp/otp_screen.dart';
import 'package:flavor_fog/screens/profile/profile_screen.dart';
import 'package:flavor_fog/screens/sign_in/sign_in_screen.dart';
import 'package:flavor_fog/screens/splash/splash_screen.dart';
import 'package:flavor_fog/screens/auth_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  AuthScreen.routeName: (context) => AuthScreen(),
  ChatsScreen.routeName: (contect) => ChatsScreen(),
  MessagesScreen.routeName: (context) => MessagesScreen(),
  RSSReader.routeName: (context) => RSSReader(),
  AccountScreen.routeName: (context) => AccountScreen(),
  ForumsScreen.routeName: (context) => ForumsScreen(),
  ProductList.routeName: (context) => ProductList(),
};
