//@dart=2.9

import 'package:flavor_fog/components/persistent_widget_tab.dart';
import 'package:flavor_fog/screens/myshop/components/reqdetail.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/components/coustom_bottom_nav_bar.dart';
import 'package:flavor_fog/enums.dart';
import 'package:flutter/scheduler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  final BuildContext menuScreenContext;
  final String name;
  final String shopId;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const HomeScreen(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false,
      this.name,
      this.shopId})
      : super(key: key);
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  run() {
    // if (widget.name != "" || widget.name != null) {
    //   SchedulerBinding.instance.addPostFrameCallback((_) {
    //     pushNewScreen(context,
    //         screen: ReqDetail(shopId: widget.shopId, name: widget.name));
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.name);
    SizeConfig().init(context);
    if (widget.name != null || widget.name != "") {
      run();
    }
    return Scaffold(
      body: Body(),

      // bottomNavigationBar: ProvidedStylesExample(
      //   menuScreenContext: menuScreenContext,
      // ),
      //     const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
