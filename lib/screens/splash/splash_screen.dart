import 'package:flavor_fog/screens/splash/components/body.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  static String routeName = "/splash";
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
