// @dart=2.9
import 'package:flavor_fog/components/news.dart';
import 'package:flavor_fog/components/rss_reader.dart';
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/routes.dart';
import 'package:flavor_fog/screens/auth_screen.dart';
import 'package:flavor_fog/screens/chats/chats_screen.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flavor_fog/screens/details/details_screen.dart';
import 'package:flavor_fog/screens/forums.dart';
import 'package:flavor_fog/screens/home/home_screen.dart';
import 'package:flavor_fog/screens/home_page.dart';
import 'package:flavor_fog/screens/messages/components/message.dart';
import 'package:flavor_fog/screens/messages/message_screen.dart';
// import 'package:flavour_fog/pages/categorylistpage.dart';

// import 'package:flavour_fog/screens/homepage.dart';
import 'package:flavor_fog/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProvidedStylesExample extends StatefulWidget {
  final BuildContext menuScreenContext;
  final String name;
  final String shopId;
  ProvidedStylesExample(
      {Key key, this.menuScreenContext, this.name, this.shopId})
      : super(key: key);

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
        menuScreenContext: widget.menuScreenContext,
        name: widget.name,
        shopId: widget.shopId,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      News(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      // HomeScreen(
      //   menuScreenContext: widget.menuScreenContext,
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),
      ForumsScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      ProfileScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/home",
          routes: routes,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.radio),
        title: ("News"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            // '/first': (context) => ProfileScreen(),
            //   '/second': (context) => MainScreen3(),
          },
        ),
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.add),
      //   title: ("Add"),
      //   activeColorPrimary: kPrimaryColor,
      //   activeColorSecondary: Colors.white,
      //   inactiveColorPrimary: Colors.white,
      //   routeAndNavigatorSettings: RouteAndNavigatorSettings(
      //     initialRoute: '/',
      //     routes: {
      //       // '/first': (context) => ProfileScreen(),
      //       // '/second': (context) => MainScreen3(),
      //     },
      //   ),
      //   // onPressed: (context) {
      //   //   pushDynamicScreen(context,
      //   //       screen: SampleModalScreen(), withNavBar: true);
      //   // },
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Community"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            // '/first': (context) => ProfileScreen(),
            //   '/second': (context) => MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Personal"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/home',
          routes: {
            // '/profile': (context) => ProfileScreen(),
            // '/auth': (context) => AuthScreen(),
            //   '/second': (context) => MainScreen3(),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Navigation Bar Demo')),
      // drawer: Drawer(
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         const Text('This is the Drawer'),
      //       ],
      //     ),
      //   ),
      // ),
      body: PersistentTabView(
        context,

        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Color(0xFF212121),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        onWillPop: (context) async {
          await showDialog(
            context: context,
            useSafeArea: true,
            builder: (context) => Container(
              height: 50.0,
              width: 50.0,
              color: Colors.white,
              child: ElevatedButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        // selectedTabScreenContext: (context) {
        //   testContext = context;
        // },
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
          colorBehindNavBar: Color(0xFF212121),
          // borderRadius: BorderRadius.circular(10.0),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style12, // Choose the nav bar style with this property
      ),
    );
  }
}
