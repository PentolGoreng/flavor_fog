//@dart=2.9
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/screens/messages/components/chat_input_field.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const MessagesScreen(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);
  static String routeName = "/message";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(),
      body: Body(),
    );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     title: Row(
  //       children: [
  //         BackButton(),
  //         CircleAvatar(
  //           backgroundImage: AssetImage("assets/images/user_2.png"),
  //         ),
  //         SizedBox(width: kDefaultPadding * 0.75),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Kristin Watson",
  //               style: TextStyle(fontSize: 16),
  //             ),
  //             Text(
  //               "Active 3m ago",
  //               style: TextStyle(fontSize: 12),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //     actions: [
  //       IconButton(
  //         icon: Icon(Icons.local_phone),
  //         onPressed: () {},
  //       ),
  //       IconButton(
  //         icon: Icon(Icons.videocam),
  //         onPressed: () {},
  //       ),
  //       SizedBox(width: kDefaultPadding / 2),
  //     ],
  //   );
  // }
}
