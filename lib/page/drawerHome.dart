import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkd/page/login.dart';

Widget isiDrawer(BuildContext context, FirebaseUser widget,
    AsyncSnapshot<DocumentSnapshot> snapshot) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("${snapshot.data['nama']}"),
          accountEmail: Text("${widget.email}"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                ? Colors.blue
                : Colors.white,
            child: Text(
              "A",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        ListTile(
          title: Text("Settings"),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          title: Text("Profile"),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          title: Text("Log Out"),
          trailing: Icon(Icons.arrow_forward),
          onTap:(){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
          
        ),
        Container(
          padding: EdgeInsets.all(40),
          width: MediaQuery.of(context).size.width,
          height: 360.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('About\n',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              Text('This is application for book your parking area\n',
                  style: TextStyle(
                    fontSize: 12,
                  )),
              Text('Beta Version 0.3',
                  style: TextStyle(
                    fontSize: 12,
                  ))
            ],
          ),
        )
      ],
    ),
  );
}
