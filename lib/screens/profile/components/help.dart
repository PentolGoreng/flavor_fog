import 'package:flavor_fog/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);
  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: "fogflavor@gmail.com",
      query: encodeQueryParameters(
          <String, String>{'subject': "Need Help", 'body': ""}),
    );
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Text(
            'Contact Us Through Email\nfogflavor@gmail.com\nby clicking here',
            style: TextStyle(color: kPrimaryColor, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          onTap: () => {launch(emailLaunchUri.toString())},
        ),
      ),
    );
  }
}
