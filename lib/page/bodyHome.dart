import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'notification.dart';
import 'package:parkd/page/bookLocation.dart';

Future navigateToBook(context, AsyncSnapshot<DocumentSnapshot> snapshot) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => BookLocation(snapshot)));
}

// Widget isiBody(BuildContext context, FirebaseUser widget) {
//   return StreamBuilder<DocumentSnapshot>(
//     stream:
//         Firestore.instance.collection('users').document(widget.uid).snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       } else if (snapshot.hasData) {
//         print(snapshot);
//         // return isiContainer(context, widget);
//         return isiContainer(context,widget,snapshot);
//       }
//       return LinearProgressIndicator();
//     },
//   );
// }

Widget isiBody(BuildContext context, FirebaseUser widget,
    AsyncSnapshot<DocumentSnapshot> snapshot) {
  String dataLokasi = '';
  String dataLantai = '';
  String dataBlok = '';
  dataLokasi = snapshot.data['bookLokasi'];
  dataLantai = snapshot.data['bookLantai'];
  dataBlok = snapshot.data['bookBlok'];

  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('./assets/wallpaper.jpg'), fit: BoxFit.cover)),
    child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.cyan[300],
              expandedHeight: 150.0,
              floating: true,
              snap: false,
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Notif()));
                  },
                ),
              ],
              flexibleSpace: Container(
                child: Container(
                  child: FlexibleSpaceBar(
                    background: Image.asset(
                      './assets/wallpaper.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 90,
                      width: 90,
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text("PARKD\n\n",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.cyan))
                        ],
                      ),
                    ),
                    Container(
                      // child: Text("Welcome, "+snapshot.data['nama']),
                      child: Text("Welcome, " + snapshot.data['nama']),
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "Saldo Anda : " + snapshot.data['saldo'].toString(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 90),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      RaisedButton(
                                        // padding: re.all(10),
                                        color: Colors.cyan,
                                        onPressed: () async {
                                          if (dataBlok != "" &&
                                              dataLantai != "" &&
                                              dataLokasi != "") {
                                            showDialog(
                                                context: context,
                                                child: new AlertDialog(
                                                  // title: new Text(""),
                                                  content: new Text(
                                                      "You have booked parking"),
                                                ));
                                          } else {
                                            await navigateToBook(
                                                context, snapshot);
                                          }
                                        },
                                        child: Text('BOOK'),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: <Widget>[
                                        RaisedButton(
                                          // padding: re.all(10),
                                          color: Colors.cyan,
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                child: new AlertDialog(
                                                  title:
                                                      new Text("TOP UP"),
                                                  content: new Text(
                                                      "Virtual Account BCA:\n12521${widget.email.length.toString()}${widget.uid.length.toString()}"),
                                                ));
                                            // crudMethods test= new crudMethods();
                                            // test.addDenah();
                                          },
                                          child: Text('TOP UP'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //history
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                itemCount: 20,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Column(
                        children: <Widget>[
                          Text('Tanggal dd-mm-yyyy'),
                          Text('data ke $index menempatkan parkir di $index')
                        ],
                      ),
                    ),
              )
            ],
          ),
        )),
  );
}
