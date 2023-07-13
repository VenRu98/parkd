import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkd/admin/drawerAdmin.dart';
import 'package:parkd/page/book.dart';

import 'bookAdmin.dart';

class BookLocationAdmin extends StatefulWidget {
  @override
  _BookLocationState createState() => _BookLocationState();
}

class _BookLocationState extends State<BookLocationAdmin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: isiDrawer(context),
      appBar: AppBar(
        title: Text("Choose Location"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: daftarGedung(),
      ),
    );
  }

  List<Widget> daftarGedung() {
    List<Widget> data = [];
    for (var i = 0; i < 1; i++) {
      data.add(GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BookAdmin()));
        },
        child: Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 3.0),
            height: 45.0,
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Universitas Kristen Maranatha",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ));
    }
    return data;
  }
}
