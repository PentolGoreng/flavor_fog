//@dart=2.9
import 'package:flavor_fog/screens/home/components/product_list.dart';
import 'package:flavor_fog/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  final search = ValueNotifier("");
  @override
  Widget currentPage;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
        valueListenable: search,
        builder: (context, value, child) {
          return Container(
            width: SizeConfig.screenWidth * 0.6,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              onSubmitted: (value) {
                search.value = value;
                Navigator.popAndPushNamed(context, "/home", arguments: search);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(9)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "Search product",
                  prefixIcon: Icon(Icons.search)),
            ),
          );
        });
  }
}
