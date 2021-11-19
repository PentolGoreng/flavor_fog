//@dart=2.9

import 'package:flavor_fog/components/persistent_widget_tab.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/components/coustom_bottom_nav_bar.dart';
import 'package:flavor_fog/enums.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const HomeScreen(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      // bottomNavigationBar: ProvidedStylesExample(
      //   menuScreenContext: menuScreenContext,
      // ),
      //     const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
