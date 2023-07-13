import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkd/admin/user.dart';
import 'package:parkd/page/login.dart';

import 'bookLocationAdmin.dart';

Widget isiDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          title: Text("Choose Location"),
          trailing: Icon(Icons.arrow_forward),
          onTap:(){
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => BookLocationAdmin()));
          },
        ),
        ListTile(
          title: Text("User"),
          trailing: Icon(Icons.arrow_forward),
          onTap:(){
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => User()));
          },
        ),

        ListTile(
          title: Text("Log Out"),
          trailing: Icon(Icons.arrow_forward),
          onTap:(){
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
          
        ),
      ],
    ),
  );
}
