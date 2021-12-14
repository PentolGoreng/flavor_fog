//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_fog/screens/args.dart';
import 'package:flavor_fog/screens/myshop/components/requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReqDetail extends StatefulWidget {
  const ReqDetail({Key key, this.shopId, this.name, this.i}) : super(key: key);
  final String shopId;
  final String name;
  final int i;
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
            String doc = dataDetail[widget.i]['doc'];
            return Column(
              children: [
                Spacer(),
                Center(
                  child: Text(_name),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(dataDetail[widget.i]['title']),
                          Text('x${dataDetail[widget.i]['number']}'),
                        ],
                      ),
                    )),
                Spacer(),
                TextButton(
                    onPressed: () async {
                      FirebaseFirestore.instance
                          .collection('shops')
                          .doc(widget.shopId)
                          .collection('deliv')
                          .add({'request': 'Accepted/Booked', 'name': _name});
                      FirebaseFirestore.instance
                          .collection('shops')
                          .doc(widget.shopId)
                          .collection('request')
                          .doc(dataDetail[widget.i]['doc'])
                          .delete();
                      print(dataDetail[widget.i]);
                    },
                    child: Text('Accept')),
                TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('shops')
                          .doc(widget.shopId)
                          .collection('deliv')
                          .add({
                        'request': 'Rejected/Unavailable',
                        "name": _name
                      });
                      FirebaseFirestore.instance
                          .collection('shops')
                          .doc(widget.shopId)
                          .collection('request')
                          .doc(dataDetail[widget.i]['doc'])
                          .delete();
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
