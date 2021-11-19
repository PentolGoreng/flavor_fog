// @dart=2.9
import 'package:flutter/material.dart';

import 'package:flavor_fog/enums.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const ProfileScreen(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      // appBar: AppBar(
      //   title: Text("Profile"),
      // ),
      body: Body(),

      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
