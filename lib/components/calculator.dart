//@dart=2.9
import 'package:flavor_fog/constants.dart';
import 'package:flavor_fog/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculator extends StatefulWidget {
  final BuildContext menuScreenContext;

  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const Calculator(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus})
      : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController iController = TextEditingController();
  TextEditingController vController = TextEditingController();
  TextEditingController rController = TextEditingController();
  TextEditingController i1Controller = TextEditingController();
  TextEditingController v1Controller = TextEditingController();
  TextEditingController r1Controller = TextEditingController();
  TextEditingController i2Controller = TextEditingController();
  TextEditingController v2Controller = TextEditingController();
  TextEditingController pController = TextEditingController();
  double i;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ohm's Law"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text('V'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: vController,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        setState(() {
                          iController.text =
                              '${(double.parse(vController.text) / double.parse(rController.text))} A';
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Voltage",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('R'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: rController,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        setState(() {
                          iController.text =
                              '${(double.parse(vController.text) / double.parse(rController.text))} A';
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Resistance",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: iController,
                      textAlignVertical: TextAlignVertical.center,
                      onSubmitted: (value) {
                        setState(() {
                          i = double.parse(value);
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Current",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('I'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('V'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: v1Controller,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        setState(() {
                          pController.text =
                              '${(double.parse(v1Controller.text) * double.parse(i1Controller.text))} W';
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Voltage",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('I'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: i1Controller,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        setState(() {
                          pController.text =
                              '${(double.parse(v1Controller.text) * double.parse(i1Controller.text))} W';
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Current",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: pController,
                      textAlignVertical: TextAlignVertical.center,
                      onSubmitted: (value) {
                        setState(() {
                          i = double.parse(value);
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Power",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('P'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('V'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      controller: v2Controller,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        setState(() {
                          r1Controller.text =
                              '${(double.parse(v2Controller.text) / double.parse(i2Controller.text))} Ohm';
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Voltage",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('I'),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: i2Controller,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (value) {
                        setState(() {
                          r1Controller.text =
                              '${(double.parse(v2Controller.text) / double.parse(i2Controller.text))} Ohm';
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Current",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      controller: r1Controller,
                      textAlignVertical: TextAlignVertical.center,
                      onSubmitted: (value) {
                        setState(() {
                          i = double.parse(value);
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(9)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: InputBorder.none,
                        hintText: "Resistance",
                        // suffixIcon: iController.text == ""
                        //     ? null
                        //     : IconButton(
                        //         icon: Icon(Icons.cancel),
                        //         onPressed: () {
                        //           setState(() {
                        //             i = 0;
                        //           });
                        //           iController.clear();
                        //         },
                        //       ),
                        // prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('R'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
