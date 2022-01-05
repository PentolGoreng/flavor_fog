//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/screens/args.dart';
import 'package:flavor_fog/screens/myshop/components/requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReqDetail extends StatefulWidget {
  const ReqDetail({
    Key key,
    this.shopId,
    this.name,
    this.doc,
  }) : super(key: key);
  final String shopId;
  final String doc;
  final String name;
  // final int i;
  static String routeName = "/reqD";

  @override
  _ReqDetailState createState() => _ReqDetailState();
}

bool exist;

Future<bool> checkExist(String docID) async {}

class _ReqDetailState extends State<ReqDetail> {
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context).settings.arguments as ScreenArguments;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('shops')
              .doc(widget.shopId)
              .collection('request')
              .where('doc', isEqualTo: widget.doc)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final dataDetail = snapshot.data.docs;
            String _name = "";
            // widget.name == "" || widget.name == null
            // ?
            _name = widget.name;
            // :
            // _name = dataDetail[0]['name'];
            // String doc = dataDetail[widget.i]['doc'];
            return Column(
              children: [
                Spacer(),
                Center(
                  child: Text(_name),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(dataDetail[0]['title']),
                      Text('x${dataDetail[0]['number']}'),
                    ],
                  ),
                ),
                Spacer(),
                TextButton(
                    onPressed: () async {
                      FirebaseFirestore.instance.collection('booked').add({
                        'request': 'Accepted/Booked',
                        'name': _name,
                        "shopId": widget.shopId,
                        "product": dataDetail[0]['title'],
                        "number": dataDetail[0]['number']
                      });
                      FirebaseFirestore.instance
                          .collection('shops')
                          .doc(widget.shopId)
                          .collection('request')
                          .doc(widget.doc)
                          .delete();
                      Navigator.of(context).pop();
                      // Navigator.of(context, rootNavigator: true).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) {
                      //       return Requests(
                      //         shopId: widget.shopId,
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    child: Text('Accept')),
                TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('booked').add({
                        'request': 'Rejected/Unavailable',
                        "name": _name,
                        "shopId": widget.shopId,
                        "product": dataDetail[0]['title'],
                        "number": dataDetail[0]['number']
                      });
                      FirebaseFirestore.instance
                          .collection('shops')
                          .doc(widget.shopId)
                          .collection('request')
                          .doc(widget.doc)
                          .delete();
                      Navigator.of(context).pop();
                      // Navigator.of(context, rootNavigator: true).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) {
                      //       return Requests(
                      //         shopId: widget.shopId,
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    child: Text('Reject/Not Available')),
              ],
            );
          },
        ),
      ),
    );
  }
}
