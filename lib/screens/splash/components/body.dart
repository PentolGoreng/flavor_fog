// @dart=2.9

import 'package:flavor_fog/screens/auth_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:flavour_fog/routes.dart';

import '../../../components/default_button.dart';
import 'package:flavor_fog/constants.dart';
import '../components/splash_content.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flavor_fog/main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PageController _controller = PageController();
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {"text": "Flavour Fog....INTRO!!", "image": "assets/logo.png"},
    {"text": "Shop here for your Vaping needs", "image": "assets/cart.png"},
    {"text": "Find or Create your vape Community", "image": "assets/chat.png"},
    {"text": "Try some of our Tools", "image": "assets/ohm.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF212121),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: new NeverScrollableScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) {
                  setState(
                    () => currentPage = value,
                  );
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 2),
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),

                              //side:
                              //BorderSide(color: Color(0xFF5C5C5C))
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          //backgroundColor:
                          //MaterialStateProperty.all(kPrimaryColor),
                        ),
                        onPressed: () {
                          currentPage < 3
                              ? Future.delayed(Duration.zero, () {
                                  _controller.animateToPage(currentPage + 1,
                                      duration: defaultDuration,
                                      curve: Curves.linear);
                                })
                              : Future.delayed(Duration.zero, () {
                                  pushNewScreen(context, screen: AuthScreen());
                                });
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: getProportionateScreenWidth(20)),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 20),
      width: currentPage == index ? 50 : 4,
      height: currentPage == index ? 8 : 4,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
