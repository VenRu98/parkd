import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkd/page/bodyHome.dart';
import 'package:parkd/page/drawerHome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkd/page/generateQR.dart';

class Home extends StatefulWidget {
  const Home({Key key, @required this.user}) : super(key: key);
  final FirebaseUser user;
  FirebaseUser getUser(){
    return user;
  }
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(widget.user.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          // return isiContainer(context, widget);
          return isiHome(context, widget.user, snapshot);
        }
        return LinearProgressIndicator();
      },
    );
  }

  // Future navigateToScan(context) async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => ScanScreen()));
  // }
}

Widget isiHome(BuildContext context, FirebaseUser widget,
    AsyncSnapshot<DocumentSnapshot> snapshot) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      //center floating action
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //isi floating action
      floatingActionButton: Container(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 5,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GenerateQR(snapshot)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('./assets/QR.png'),
                  width: 45.0,
                  height: 45.0,
                ),
                Text(
                  'Show',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  'QR',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            )),
      ),

      // navigation bar
      bottomNavigationBar: Container(
        height: 50.0,
        child: TabBar(
          tabs: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                child: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0))),
            Container(
                height: MediaQuery.of(context).size.height,
                child:
                    Icon(Icons.history, color: Color.fromARGB(255, 0, 0, 0))),
          ],
        ),
      ),
      //drawer
      drawer: isiDrawer(context, widget, snapshot),
      body: isiBody(context, widget, snapshot),
    ),
  );
}
