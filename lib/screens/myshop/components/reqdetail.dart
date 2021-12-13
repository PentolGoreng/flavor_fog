//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/screens/args.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReqDetail extends StatefulWidget {
  const ReqDetail({Key key, this.shopId, this.name}) : super(key: key);
  final String shopId;
  final String name;
  static String routeName = "/reqD";
  @override
  _ReqDetailState createState() => _ReqDetailState();
}

class _ReqDetailState extends State<ReqDetail> {
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context).settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('shops')
            .doc(widget.shopId)
            .collection('request')
            .where('name', isEqualTo: widget.name)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final dataDetail = snapshot.data.docs;
          String _name = "";
          widget.name == "" || widget.name == null
              ? _name = widget.name
              : _name = dataDetail[0]['name'];

          return Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text(dataDetail[0]['title']),
                    Text(_name),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
