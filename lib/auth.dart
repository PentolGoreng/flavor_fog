// //@dart=2.9

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flavor_fog/helperfun/sharedpref_helper.dart';
// import 'package:flavor_fog/services/database.dart';
// import 'package:flavor_fog/screens/home/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthMethods {
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   //get current user
//   getCurrentUser() async {
//     return auth.currentUser;
//   }

//   Future<User> signInWithGoogle(BuildContext context) async {
//     final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//     final GoogleSignIn _googleSignIn = new GoogleSignIn();

//     final GoogleSignInAccount googleSignInAccount =
//         await _googleSignIn.signIn();

//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;

//     final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken);

//     UserCredential result =
//         await _firebaseAuth.signInWithCredential(credential);
//     User userDetails = result.user;

//     if (result == null) {
//     } else {
//       SharedPreferenceHelper().saveUserEmail(userDetails.email);
//       SharedPreferenceHelper().saveUserId(userDetails.uid);
//       SharedPreferenceHelper()
//           .saveUserName(userDetails.email.replaceAll("@gmail.com", ""));
//       SharedPreferenceHelper().saveDisplayName(userDetails.displayName);
//       SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL);

//       DatabaseMethods()
//           .addUserInfoToDB(
//               userID: userDetails.uid,
//               email: userDetails.email,
//               username: userDetails.email.replaceAll("@gmail.com", ""),
//               name: userDetails.displayName,
//               profileUrl: userDetails.photoURL)
//           .then(() {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => HomeScreen()));
//       });
//     }
//   }

//   Future signOut() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//     await auth.signOut();
//   }
// }
