import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkd/page/bookDeal.dart';
import 'package:parkd/page/bookLocation.dart';
import 'package:parkd/service/crud.dart';

class Book extends StatefulWidget {
  AsyncSnapshot<DocumentSnapshot> _snapshot;

  Book( AsyncSnapshot<DocumentSnapshot> snapshot) {

    _snapshot = snapshot;
  }

  @override
  _BookState createState() => _BookState(_snapshot);
}

class _BookState extends State<Book> {

  AsyncSnapshot<DocumentSnapshot> _snapshot;

  _BookState( AsyncSnapshot<DocumentSnapshot> snapshot) {

    _snapshot = snapshot;
  }
  int warnaB1 = 300;
  int warnaB2 = 50;
  int warnaB3 = 50;
  Widget isiParkir;
  @override
  void initState() {
    super.initState();

    isiParkir = denahParkir(context, 1, "B1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book'),
      ),
      body: Stack(
        children: <Widget>[
          isiParkir,
          Container(
            // height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    warnaB3 = 50;
                    warnaB2 = 50;
                    warnaB1 = 300;
                    isiParkir = denahParkir(context, 1, "B1");
                    setState(() {});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[warnaB1],
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        "B1",
                        textScaleFactor: 2.0,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    isiParkir = denahParkir(context, 2, "B2");
                    warnaB3 = 50;
                    warnaB2 = 300;
                    warnaB1 = 50;
                    setState(() {});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[warnaB2],
                          border: Border.all(color: Colors.black)),
                      child: Text("B2", textScaleFactor: 2.0)),
                ),
                GestureDetector(
                  onTap: () {
                    isiParkir = denahParkir(context, 3, "B3");
                    warnaB3 = 300;
                    warnaB2 = 50;
                    warnaB1 = 50;
                    setState(() {});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow[warnaB3],
                          border: Border.all(color: Colors.black)),
                      child: Text("B3", textScaleFactor: 2.0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget denahParkir(BuildContext context, int kondisi, String lantai) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('denahParkirUKM')
          .document('blok$lantai')
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(top: 100.0),
            alignment: Alignment.center,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            height: 362.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: EdgeInsets.only(left: 50.0, right: 50.0),
                  // height: 500.0,
                  // width: MediaQuery.of(context).size.width,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: barisKolom(kondisi, snapshot, lantai),
                  ),
                ),
              ],
            ),
          );
          // return isiContainer(context, widget);
          // return isiHome(context, widget.user, snapshot);
        }
        return LinearProgressIndicator();
      },
    );
    ;
  }

  List<Widget> barisKolom(
      int kondisi, AsyncSnapshot<DocumentSnapshot> snapshot, String lantai) {
    List array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"];
    int total = 0;
    List<Widget> isi = [];
    for (var j = 1; j <= 9; j++) {
      isi.add(Row(children: kolom(total, j, kondisi, snapshot, lantai)));
      total += 6;
    }
    return isi;
  }

  List<Widget> kolom(int total, int j, int kondisi,
      AsyncSnapshot<DocumentSnapshot> snapshot, String lantai) {
    // List isiKondisi = snapshot.data['kondisi'];

    // print(isiKondisi.toString());
    List<Widget> isi = [];
    for (var i = 1; i <= 6; i++) {
      // total++;
      if (kondisi == 1) {
        if ((j == 1 && (i >= 2 && i <= 5)) ||
            (i == 1 && (j >= 3 && j <= 8)) ||
            (i == 6 && (j >= 3 && j <= 8)) ||
            ((j >= 3 && j <= 7) && (i >= 3 && i <= 4))) {
          isi.add(GestureDetector(
            onTap: () {
              // print(snapshot.data['kondisi'][(total-7)+i]);
              // snapshot.data['kondisi'][(total-7)+i]=true;
              // print(snapshot.data['kondisi'][(total-7)+i]);
              // setState(() {
                
              // });
              // List isiKondisi = snapshot.data['kondisi'];
              // crudMethods test=crudMethods();
              // isiKondisi[(total-7)+i]=false;
              // print(isiKondisi.toList());
              // // test.updateDenah('blok$lantai', {
              // //   'kondisi' : FieldValue.arrayRemove(["true","false"]),
              // // });
              // test.updateDenah('blok$lantai', {
              //   'kondisi' : isiKondisi,
              // });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDeal(
                          (total - 7) + i, snapshot, _snapshot)));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: snapshot.data['kondisi'][total]
                      ? Colors.red
                      : Colors.green,
                  border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data['blok'][total]),
                  // Text(dummy + i.toString()),
                ],
              ),
              width: 50.0,
              height: 40.0,
            ),
          ));
        } else {
          isi.add(Container(
            child: Text(' '),
            width: 50.0,
            height: 40.0,
          ));
        }
      } else if (kondisi == 2) {
        if ((j == 1 && (i >= 2 && i <= 6)) ||
            (i == 1 && (j >= 3 && j <= 8)) ||
            (i == 6 && (j >= 1 && j <= 8)) ||
            (j == 9 && (i >= 3 && i <= 4)) ||
            ((j >= 3 && j <= 7) && (i >= 3 && i <= 4))) {
          isi.add(GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDeal(
                          (total - 7) + i, snapshot, _snapshot)));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: snapshot.data['kondisi'][total]
                      ? Colors.red
                      : Colors.green,
                  border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data['blok'][total]),
                ],
              ),
              width: 50.0,
              height: 40.0,
            ),
          ));
        } else {
          isi.add(Container(
            child: Text(' '),
            width: 50.0,
            height: 35.0,
          ));
        }
      } else if (kondisi == 3) {
        if ((j == 1 && (i >= 2 && i <= 6)) ||
            (i == 1 && (j >= 3 && j <= 8)) ||
            (i == 6 && (j >= 1 && j <= 9)) ||
            (j == 9 && (i >= 3 && i <= 4)) ||
            ((j >= 3 && j <= 7) && (i >= 3 && i <= 4))) {
          isi.add(GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDeal(
                          (total - 7) + i, snapshot, _snapshot)));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: snapshot.data['kondisi'][total]
                      ? Colors.red
                      : Colors.green,
                  border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data['blok'][total]),
                ],
              ),
              width: 50.0,
              height: 40.0,
            ),
          ));
        } else {
          isi.add(Container(
            child: Text(' '),
            width: 50.0,
            height: 40.0,
          ));
        }
      }
      total++;
    }
    return isi;
  }
}
