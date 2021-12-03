//@dart=2.9

import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flavor_fog/screens/home/home_screen.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  AnimationController _animationController;
  Animation<double> _animationTextRotate;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController1 = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  bool isLoading = false;
  RegExp regExp1 = RegExp(r'[^A-Za-z0-9]');
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController password = TextEditingController();
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // BuildContext context;
  // AppMethods appMethods = Auth as AppMethods;
  _AuthScreenState();

  void inputData1() {
    setState(() {
      final Cuser = FirebaseAuth.instance.currentUser;
      final uid = Cuser.uid;
      collection.doc(uid) // <-- Document ID
          .set({
        'name': name.text,
        'email': emailController1.text,
        'uid': uid,
        'address': '+Add address',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/flavour-fog.appspot.com/o/Profile%2Fprofile.jpg?alt=media&token=ddf7ce8f-70b7-40c9-beaf-e4fb8688c6d8',
      }).catchError((error) => print('Add failed: $error'));
      ;
    });
  }

  void inputData() {
    setState(() {
      final user = FirebaseAuth.instance.currentUser;
      final uid = user.uid;
    });

    // here you write the codes to input the data into firestore
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
        await widget._auth.createUserWithEmailAndPassword(
            email: emailController1.text, password: passwordController1.text);
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
    }
  }

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isShowSignUp = false;
  @override
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
                                    onPressed: () {},
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
                              Spacer(),
                              TextFormField(
                                style: TextStyle(color: Colors.white),
                                onChanged: (value) {
                                  print(value);
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
                        onTap: () async {
                          if (_isShowSignUp) {
                            // try {
                            try {
                              vaildation();
                            } catch (e) {
                              print(e);
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
                          child: Text("Sign Up".toUpperCase(),
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

