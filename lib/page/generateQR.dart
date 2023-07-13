import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkd/page/home.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'bodyHome.dart';

class GenerateQR extends StatefulWidget {
  AsyncSnapshot<DocumentSnapshot> _snapshot;
  GenerateQR(AsyncSnapshot<DocumentSnapshot> snapshot){
    _snapshot=snapshot;
  }

  

  @override
  _GenerateQRState createState() => _GenerateQRState(_snapshot);
}

class _GenerateQRState extends State<GenerateQR> {
 AsyncSnapshot<DocumentSnapshot> _snapshot;
  String dataLokasi = '';
  String dataLantai = '';
  String dataBlok = '';
  String dataBlokID = '';
  String dataUser = '';

  _GenerateQRState(AsyncSnapshot<DocumentSnapshot> snapshot) {
   _snapshot=snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(_snapshot.data['uid'])
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          dataLokasi = snapshot.data['bookLokasi'];
          dataLantai = snapshot.data['bookLantai'];
          dataBlok = snapshot.data['bookBlok'];
          dataUser=snapshot.data['uid'];
          dataBlokID=snapshot.data['bookBlokID'].toString();
          return isiGenerateQR(context, dataLokasi,dataLantai,dataBlok, snapshot,dataUser);
        }
        return LinearProgressIndicator();
      },
    );
  }

  Widget isiGenerateQR(BuildContext context, String dataLokasi, String dataLantai, String dataBlok, AsyncSnapshot<DocumentSnapshot> snapshot, String dataUser) {
    if (dataBlok == "" && dataLantai == "" && dataLokasi == "") {
      return Scaffold(
        appBar: AppBar(
          title: Text('QR'),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  alignment: Alignment.center,
                  color: Colors.cyan,
                  width: 250.0,
                  height: 100.0,
                  child: Text(
                    'Please Book your parking space',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                RaisedButton(
                  // padding: re.all(10),
                  color: Colors.cyan,
                  onPressed: () async {
                    await navigateToBook(context, snapshot);
                  },
                  child: Text('BOOK'),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('QR'),
          // leading: GestureDetector(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     child: Icon(Icons.arrow_back)),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: QrImage(
                  data: "$dataUser+$dataLokasi+$dataLantai+$dataBlok+$dataBlokID",
                  size: 200.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Lokasi:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      dataLokasi,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "Lantai:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      dataLantai,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "Blok:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      dataBlok,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
