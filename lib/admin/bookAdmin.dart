import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkd/admin/drawerAdmin.dart';
import 'package:parkd/service/crud.dart';

class BookAdmin extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<BookAdmin> {
  String barcode = "";
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
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 5,
            onPressed: () async {
              crudMethods obj = crudMethods();
              var isiBarcode;
              scan().whenComplete(() {
                isiBarcode = barcode.split("+");
                int id = int.parse(isiBarcode[4]) ;
                var test = obj.getDenah('blok${isiBarcode[2]}');
                test.then((result) {
                  List isiKondisi = result.data['kondisi'];
                  isiKondisi[id] = false;
                      
                  obj.updateDenah('blok${isiBarcode[2]}',
                      {'kondisi': isiKondisi});
                });

                obj.updateDataUser(isiBarcode[0], {
                  'bookBlok': '',
                  'bookLantai': '',
                  'bookLokasi': '',
                  'bookBlokID': 0
                });
              });
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
                  'Scan',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
                Text(
                  'QR',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            )),
      ),
      appBar: AppBar(
        title: Text('Universitas Kristen Maranatha'),
      ),
      drawer: isiDrawer(context),
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
              // crudMethods test=crudMethods();
              // isiKondisi[(total-7)+i]=true;
              // print(isiKondisi.toList());
              // test.updateDenah('blok$lantai', {
              //   'kondisi' : isiKondisi
              // });
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             BookDeal((total - 7) + i, snapshot, _snapshot)));
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             BookDeal((total - 7) + i, snapshot, _snapshot)));
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             BookDeal((total - 7) + i, snapshot, _snapshot)));
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

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
