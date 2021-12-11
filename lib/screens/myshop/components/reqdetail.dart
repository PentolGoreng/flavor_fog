import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReqDetail extends StatefulWidget {
  const ReqDetail({Key? key, required this.shopId, required this.name})
      : super(key: key);
  final String shopId;
  final String name;

  @override
  _ReqDetailState createState() => _ReqDetailState();
}

class _ReqDetailState extends State<ReqDetail> {
  @override
  Widget build(BuildContext context) {
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
          return Expanded(
            child:
                Column(children: [Center(child: Text(dataDetail[0]['title']))]),
          );
        },
      ),
    );
  }
}
