//@dart=2.9

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flavor_fog/auth.config.dart';
import 'package:flavor_fog/screens/forgot_password/forgot_password_screen.dart';
import 'package:flavor_fog/screens/home/home_screen.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

// import 'package:flavor_fog/auth.dart';
// import 'package:flavor_fog/components/custom-widget-tabs.widget.dart';
import 'package:flavor_fog/components/persistent_widget_tab.dart';
import 'package:flavor_fog/constants.dart';
// import 'package:flavor_fog/helpers/utils.dart';
import 'package:flavor_fog/main.dart';
// import 'package:flavor_fog/services/loginservice.dart';

class AuthScreen extends StatefulWidget {
  final _auth = FirebaseAuth.instance;

  static String routeName = "/auth";

  AuthScreen({Key key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final Cuser = FirebaseAuth.instance.currentUser;

  AnimationController _animationController;
  Animation<double> _animationTextRotate;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  EmailAuth emailAuth;
  Timer _timer;
  int _start = 10;
  bool isLoading = false;
  RegExp regExp1 = RegExp(r'[^A-Za-z0-9]');
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();
  bool submitValid = false;
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // BuildContext context;
  // AppMethods appMethods = Auth as AppMethods;
  _AuthScreenState();

  void inputData1() async {
    var status = await OneSignal.shared.getDeviceState();
    setState(() {
      _tokenId = status.userId;
    });
    setState(() {
      final Cuser = FirebaseAuth.instance.currentUser;
      final uid = Cuser.uid;
      collection.doc(uid) // <-- Document ID
          .set({
        'name': name.text,
        'email': emailController1.text,
        'uid': uid,
        'address': '',
        "token": _tokenId,
        'image':
            'https://firebasestorage.googleapis.com/v0/b/flavour-fog.appspot.com/o/Profile%2Fprofile.jpg?alt=media&token=ddf7ce8f-70b7-40c9-beaf-e4fb8688c6d8',
      }).catchError((error) => print('Add failed: $error'));
    });
  }

  void inputData() async {
    var status = await OneSignal.shared.getDeviceState();
    setState(() {
      _tokenId = status.userId;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid) // <-- Document ID
        .update({
      "token": _tokenId,
    }).catchError((error) => print('Add failed: $error'));

    final shopDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (shopDoc.data().containsValue("hasShop")) {
        FirebaseFirestore.instance
            .collection('shop')
            .doc(shopDoc['shopId'])
            .update({
          "token": _tokenId,
        }).catchError((error) => print('Add failed: $error'));
      }
      // here you write the codes to input the data into firestore
    });
  }

  // final User user = FirebaseAuth.instance.currentUser;

  var collection = FirebaseFirestore.instance.collection('users');
  void submit(context) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      // pushNewScreen(context, screen: () {} );

      print(result);
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message;
      }
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message.toString()),
          duration: Duration(milliseconds: 800),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 800),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  void vaildation2() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All Fields Are Empty'),
        ),
      );
    } else if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email Is Empty'),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Try Vaild Email'),
        ),
      );
    } else if (RegExp(r"\s\b|\b\s").hasMatch(password.text) ||
        !RegExp(r'^[a-zA-Z0-9_\.]+$').hasMatch(password.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only Use AplhaNumeric And (-, _, .) And No Spaces'),
        ),
      );
    } else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Is Empty'),
        ),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password  Is Too Short'),
        ),
      );
    } else {
      try {
        await widget._auth.signInWithEmailAndPassword(
            email: email.text, password: password.text);

        await inputData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login SuccesFul'),
            duration: Duration(seconds: 5),
          ),
        );
        pushNewScreen(context,
            screen: ProvidedStylesExample(
              menuScreenContext: context,
            ));
      } on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text(' Ops! Login Failed'),
                  content: Text(e.message),
                ));
      }
    }
  }

  String existName;
  void vaildation() async {
    if (emailController1.text.isEmpty &&
        passwordController1.text.isEmpty &&
        name.text.isEmpty &&
        passwordController2.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All Flied Are Empty'),
        ),
      );
    } else if (emailController1.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email Is Empty'),
        ),
      );
    } else if (passwordController2.text.isEmpty ||
        passwordController2.text != passwordController1.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirm Password Should Be The Same'),
        ),
      );
    } else if (!regExp.hasMatch(emailController1.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Try Vaild Email'),
        ),
      );
    } else if (RegExp(r"\s\b|\b\s").hasMatch(name.text) ||
        !RegExp(r'^[a-zA-Z0-9_\.]+$').hasMatch(name.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only Use AplhaNumeric And (-, _, .) And No Spaces'),
        ),
      );
    } else if (RegExp(r"\s\b|\b\s").hasMatch(passwordController1.text) ||
        !RegExp(r'^[a-zA-Z0-9_\.]+$').hasMatch(passwordController1.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only Use AplhaNumeric And (-, _, .) And No Spaces'),
        ),
      );
    } else if (RegExp(r"\s\b|\b\s").hasMatch(passwordController2.text) ||
        !RegExp(r'^[a-zA-Z0-9_\.]+$').hasMatch(passwordController2.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only Use AplhaNumeric And (-, _, .) And No Spaces'),
        ),
      );
    } else if (passwordController1.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Is Empty'),
        ),
      );
    } else if (name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Set Username'),
        ),
      );
    } else if (passwordController1.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password  Is Too Short'),
        ),
      );
    } else {
      try {
// if the size of value is greater then 0 then that doc exist.
        await FirebaseFirestore.instance
            .collection('users')
            .where('name', isEqualTo: name.text)
            .get()
            .then((value) async {
          if (value.size > 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Username Already Exists'),
              ),
            );
          } else {
            try {
              await widget._auth.createUserWithEmailAndPassword(
                  email: emailController1.text,
                  password: passwordController1.text);
              inputData1();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sucessfully Register.You Can Login Now'),
                  duration: Duration(seconds: 5),
                ),
              );
              updateView();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
            ;
          }
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _tokenId;

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
    emailAuth = new EmailAuth(
      sessionName: "Flavour Fog OTP",
    );

    /// Configuring the remote server

    emailAuth.config(remoteServerConfiguration);
  }

  @override
  void verify() {
    bool result = emailAuth.validateOtp(
        recipientMail: emailController1.value.text,
        userOtp: _otpcontroller.value.text);
    if (result) {
      vaildation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP Code is Wrong'),
        ),
      );
    }
  }

  void sendOtp() async {
    if (emailController1.text.isEmpty &&
        passwordController1.text.isEmpty &&
        name.text.isEmpty &&
        passwordController2.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All Flied Are Empty'),
        ),
      );
    } else if (emailController1.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email Is Empty'),
        ),
      );
    } else if (passwordController2.text.isEmpty ||
        passwordController2.text != passwordController1.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirm Password Should Be The Same'),
        ),
      );
    } else if (!regExp.hasMatch(emailController1.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Try Vaild Email'),
        ),
      );
    } else if (RegExp(r"\s\b|\b\s").hasMatch(name.text) ||
        !RegExp(r'^[a-zA-Z0-9_\.]+$').hasMatch(name.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only Use AplhaNumeric And (-, _, .) And No Spaces'),
        ),
      );
    } else if (RegExp(r"\s\b|\b\s").hasMatch(passwordController1.text) ||
        !RegExp(r'^[a-zA-Z0-9_\.]+$').hasMatch(passwordController1.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only Use AplhaNumeric And (-, _, .) And No Spaces'),
        ),
      );
    } else if (RegExp(r"\s\b|\b\s").hasMatch(passwordController2.text) ||
        !RegExp(r'^[a-zA-Z0-9_\.]+$').hasMatch(passwordController2.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only Use AplhaNumeric And (-, _, .) And No Spaces'),
        ),
      );
    } else if (passwordController1.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Is Empty'),
        ),
      );
    } else if (name.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Set Username'),
        ),
      );
    } else if (passwordController1.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password  Is Too Short'),
        ),
      );
    } else {
      bool result = await emailAuth.sendOtp(
          recipientMail: emailController1.value.text, otpLength: 5);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check your Email'),
          ),
        );
        // using a void function because i am using a
        // stateful widget and seting the state from here.
        setState(() {
          submitValid = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("We Couldn't Send the OTP"),
          ),
        );
      }
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  bool _isShowSignUp = false;
  @override
  void _getData() async {
    var status = await OneSignal.shared.getDeviceState();
    setState(() {
      _tokenId = status.userId;
    });
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // LoginService loginService =
    //     Provider.of<LoginService>(context, listen: false);
    // this.context = context;

    // String email;
    // String password;
    //kasi nilai ukuran layar
    final _size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedBuilder(
            animation: _animationController,
            builder: (context, snapshot) {
              return Stack(children: [
                AnimatedPositioned(
                    duration: defaultDuration,
                    width: _size.width * 0.88,
                    height: _size.height,
                    left: _isShowSignUp ? -_size.width * 0.76 : 0,
                    child: Container(
                        decoration: _isShowSignUp
                            ? BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: kPrimaryColor,
                                  ),
                                  BoxShadow(
                                      color: login_bg,
                                      offset: Offset.fromDirection(
                                          !_isShowSignUp ? 0 : 270, -5),
                                      blurRadius: 4,
                                      spreadRadius: 4),
                                ],
                              )
                            : null,
                        // color: _isShowSignUp ? Colors.brown.shade200 : login_bg,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.13),
                            child: Form(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Spacer(),
                                  Spacer(),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {},
                                    controller: email,
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: defaultPadding),
                                    child: TextFormField(
                                      controller: password,
                                      onChanged: (value) {
                                        print(password.text);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 8) {
                                          return 'Please enter password';
                                        }
                                        return value;
                                      }, // <= NEW
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      pushNewScreen(context,
                                          screen: ForgotPasswordScreen());
                                    },
                                    child: const Text(
                                      "Forgot Password?",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Spacer(flex: 2),
                                ]))))),
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                  child: Container(
                    decoration: !_isShowSignUp
                        ? BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor,
                              ),
                              BoxShadow(
                                  color: login_bg,
                                  offset: Offset.fromDirection(
                                      !_isShowSignUp ? 270 : 0, 5),
                                  blurRadius: 4,
                                  spreadRadius: 4),
                            ],
                          )
                        : null,
                    // color: !_isShowSignUp ? kPrimaryColor : login_bg,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.13),
                      child: Form(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                // obscureText: true,
                                controller: name,
                                onChanged: (value) {
                                  print(value);
                                },
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  // print(value);
                                  // setState(() {
                                  //   submitValid = false;
                                  // });
                                },
                                // obscureText: true,
                                controller: emailController1,
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  onChanged: (value) {
                                    print(value);
                                  },
                                  controller: passwordController1,
                                  decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                onChanged: (value) {
                                  print(value);
                                },
                                controller: passwordController2,
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              (submitValid)
                                  ? TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      // obscureText: true,
                                      onChanged: (value) {
                                        print(value);
                                      },
                                      controller: _otpcontroller,
                                      decoration: const InputDecoration(
                                        fillColor: Colors.white,
                                        hintText: "OTP",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 1,
                                    ),
                              (submitValid)
                                  ? TextButton(
                                      onPressed: () {
                                        setState(() {
                                          submitValid = false;
                                        });
                                      },
                                      child: Text('Want to Re-Send OTP?'))
                                  : Container(
                                      height: 1,
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Terms & Conditions'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                    'Terms & Conditions\n\nBy downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to TriGee.\n\nTriGee is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\n\nThe Flavour Fog app stores and processes personal data that you have provided to us, to provide our Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Flavour Fog app won’t work properly or at all.\n\nThe app does use third-party services that declare their Terms and Conditions.\n\nLink to Terms and Conditions of third-party service providers used by the app'),
                                                GestureDetector(
                                                  child: Text(
                                                    'Google Play Services',
                                                    style: TextStyle(
                                                        color: kPrimaryColor),
                                                  ),
                                                ),
                                                Text(
                                                    'You should be aware that there are certain things that TriGee will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but TriGee cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.\n\nIf you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\n\nAlong the same lines, TriGee cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, TriGee cannot accept responsibility.\n\nWith respect to TriGee’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. TriGee accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.\n\nAt some point, we may wish to update the app. The app is currently available on Android – the requirements for the system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. TriGee does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.\n\nChanges to This Terms and Conditions\n\nWe may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page.\n\nThese terms and conditions are effective as of 2021-12-13\n\nContact Us\n\nIf you have any questions or suggestions about our Terms and Conditions, do not hesitate to contact us at fogflavor@gmail.com.'),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Center(
                                  child: Text(
                                    'By Creating an Account, Our Terms & Conditions Will Automatically Apply To You',
                                    style: TextStyle(
                                        fontSize: 10, color: kPrimaryColor),
                                  ),
                                ),
                              ),
                              Spacer(flex: 2),
                            ]),
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   width: _size.width,
                //   bottom: _size.height * 0.1,
                //   // child:
                //   // SocialButtons(),
                // ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 50,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Flavour Fog',
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  left: _isShowSignUp ? 0 : _size.width * 0.44 - 54,
                  bottom: _isShowSignUp ? _size.height / 2 : _size.height * 0.2,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    style: TextStyle(
                      fontSize: _isShowSignUp ? 20 : 32,
                      fontWeight: FontWeight.bold,
                      color: _isShowSignUp ? kPrimaryColor : Colors.white70,
                    ),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onDoubleTap: () {
                          null;
                        },
                        onTap: () async {
                          isLoading == false;

                          if (_isShowSignUp) {
                            updateView();
                          } else {
                            print(emailController.text);
                            vaildation2();
                          }
                        },

                        // async {
                        //   if (_isShowSignUp) {
                        //     updateView();
                        //   } else {
                        //     print(emailController.text);
                        //     try {
                        //       await widget._auth.signInWithEmailAndPassword(
                        //           email: emailController.text,
                        //           password: passwordController.text);
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(
                        //           content: Text(
                        //               'Sucessfully Register.You Can Login Now'),
                        //           duration: Duration(seconds: 5),
                        //         ),
                        //       );
                        //       pushNewScreen(context,
                        //           screen: ProvidedStylesExample(
                        //             menuScreenContext: context,
                        //           ));
                        //     } on FirebaseAuthException catch (e) {
                        //       showDialog(
                        //           context: context,
                        //           builder: (ctx) => AlertDialog(
                        //                 title:
                        //                     Text(' Ops! Registration Failed'),
                        //                 content: Text('${e.message}'),
                        //               ));
                        //     }
                        //   }
                        // },

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                          width: 160,
                          // color: Colors.blue,
                          child: Text(
                            "Log In".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: defaultDuration,
                  right: _isShowSignUp ? _size.width * 0.44 - 80 : 0,
                  bottom: !_isShowSignUp
                      ? _size.height / 2 - 80
                      : _size.height * 0.2,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    style: TextStyle(
                      fontSize: !_isShowSignUp ? 20 : 32,
                      fontWeight: FontWeight.bold,
                      color: !_isShowSignUp ? kPrimaryColor : Colors.white70,
                    ),
                    child: Transform.rotate(
                      angle: (90 - _animationTextRotate.value) * pi / 180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onDoubleTap: () {
                          null;
                        },
                        onTap: () async {
                          if (_isShowSignUp) {
                            // try {
                            submitValid;
                            if (!submitValid) {
                              sendOtp();
                              startTimer();
                            } else {
                              verify();
                              // try {
                              //   vaildation();
                              // } catch (e) {
                              //   print(e);
                              // }

                            }

                            //   Navigator.of(context).pop();
                            // } on FirebaseAuthException catch (e) {
                            //   showDialog(
                            //       context: context,
                            //       builder: (ctx) => AlertDialog(
                            //             title: const Text(
                            //                 ' Ops! Registration Failed'),
                            //             content: Text(e.message),
                            //           ));

                            // setState(() {

                            // });

                            // <-- Your data

                          } else {
                            updateView();
                            !submitValid;
                          }
                          // },
                          //   if (_isShowSignUp) {
                          //     try {
                          //       await widget._auth.createUserWithEmailAndPassword(
                          //           email: emailController1.text,
                          //           password: passwordController1.text);
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //           content: Text(
                          //               'Sucessfully Register.You Can Login Now'),
                          //           duration: Duration(seconds: 5),
                          //         ),
                          //       );
                          //       Navigator.of(context).pop();
                          //     } on FirebaseAuthException catch (e) {
                          //       showDialog(
                          //           context: context,
                          //           builder: (ctx) => AlertDialog(
                          //                 title:
                          //                     Text(' Ops! Registration Failed'),
                          //                 content: Text('${e.message}'),
                          //               ));
                          //     }
                          //     ;
                          //   } else {
                          //     updateView();
                          //   }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding * 0.75),
                          width: 160,
                          //color: Colors.blue,
                          child: Text(
                              !_isShowSignUp
                                  ? "Sign Up"
                                  : (submitValid)
                                      ? "Sign Up"
                                      : _start > 0 && _start < 10
                                          ? _start.toString()
                                          : "Request OTP".toUpperCase(),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
            }));
  }
}

//   verifyDetails() async {
//     if (fullname.text == "") {
//       showSnackBar(message: " Full name cannot be empty", key: scaffoldKey);
//       return;
//     }
//     if (email.text == "") {
//       showSnackBar(message: "Email cannot be empty", key: scaffoldKey);
//       return;
//     }
//     if (password.text == "" || password.text.length < 6) {
//       showSnackBar(
//           message: "Password cannot be empty or passord is too short",
//           key: scaffoldKey);
//       return;
//     }
//     if (re_password.text == "") {
//       showSnackBar(message: "Please re-enter your password", key: scaffoldKey);
//       return;
//     }
//     if (password.text != re_password.text) {
//       showSnackBar(message: "Passwords don't match", key: scaffoldKey);
//       return;
//     }
//     if (phoneNumber.text == "") {
//       showSnackBar(message: "Please enter your phone number", key: scaffoldKey);
//       return;
//     }
//     displayProgressDialog(context);
//     String response = await appMethods.createUser(
//         fullname: fullname.text.toLowerCase(),
//         email: email.text.toLowerCase(),
//         password: password.text.toLowerCase(),
//         phone: phoneNumber.text);

//     if (response == successful) {
//       closeProgressDialog(context);
//       Navigator.of(context).pop(true);
//       Navigator.of(context).pop(true);
//     } else {
//       closeProgressDialog(context);
//       showSnackBar(message: response, key: scaffoldKey);
//     }
//   }

//   verifyLogin() async {
//     if (email.text == "") {
//       showSnackBar(message: "Email cannot be empty", key: scaffoldKey);
//       return;
//     } else if (password.text == "") {
//       showSnackBar(message: "Password cannot be empty", key: scaffoldKey);
//       return;
//     }
//     displayProgressDialog(context);
//     String response = await appMethods.loginUser(
//         email: email.text.toLowerCase(), password: password.text.toLowerCase());
//     if (response == successful) {
//       closeProgressDialog(context);
//       Navigator.of(context).pop(true);
//     } else {
//       closeProgressDialog(context);
//       showSnackBar(message: response.toString(), key: scaffoldKey);
//     }
//   }

//   showDialogue() {}
