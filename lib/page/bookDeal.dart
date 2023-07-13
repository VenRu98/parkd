import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkd/page/book.dart';
import 'package:parkd/page/generateQR.dart';
import 'package:parkd/page/home.dart';
import 'package:parkd/service/crud.dart';

class BookDeal extends StatefulWidget {
  int id;

  AsyncSnapshot<DocumentSnapshot> _snapshot, _snapshotUser;
  BookDeal(int i, AsyncSnapshot<DocumentSnapshot> snapshot,
  AsyncSnapshot<DocumentSnapshot> snapshotUser) {
    id = i;
    _snapshot = snapshot;
    _snapshotUser = snapshotUser;
  }

  @override
  _BookDealState createState() => _BookDealState(id, _snapshot, _snapshotUser);
}

class _BookDealState extends State<BookDeal> {
  int id;

  AsyncSnapshot<DocumentSnapshot> _snapshot, _snapshotUser;
  _BookDealState(int i, AsyncSnapshot<DocumentSnapshot> snapshot,
      AsyncSnapshot<DocumentSnapshot> snapshotUser) {
    id = i;

    _snapshot = snapshot;
    _snapshotUser = snapshotUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 5),
              child: Row(
                children: <Widget>[
                  Container(
                      color: Colors.cyan,
                      width: 80.0,
                      height: 80.0,
                      child: SizedBox(
                          width: 68,
                          height: 68,
                          child: Center(
                              child: Text(
                            "${_snapshot.data['blok'][id]}",
                            style: TextStyle(fontSize: 25),
                          )))),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(20.0, 20, 0, 0),
                                child: Text(
                                  "Rp. 5000",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.fromLTRB(20.0, 10, 0, 0),
                                  // width: MediaQuery.of(context).size.width - 140,
                                  child: Text(
                                    "${_snapshot.data['lokasi']}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 15),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              // margin: EdgeInsets.fromLTRB(40, 4, 0, 0),
              width: 200.0,
              height: 50.0,
              child: Text("Lantai ${_snapshot.data['lantai']}",
                  style: TextStyle(fontSize: 25)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              // margin: EdgeInsets.fromLTRB(40, 4, 0, 0),
              width: 200.0,
              height: 50.0,
              child: Text("Blok ${_snapshot.data['blok'][id]}",
                  style: TextStyle(fontSize: 25)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(55, 30, 0, 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      // Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.cancel,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(140, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        if (_snapshotUser.data['saldo'] - 5000 >= 0) {
                          List isiKondisi = _snapshot.data['kondisi'];
                          isiKondisi[id] = true;
                          crudMethods test = crudMethods();
                          test.updateDenah('blok${_snapshot.data['lantai']}',
                              {'kondisi': isiKondisi});
                          var sisaSaldo = _snapshotUser.data['saldo'] - 5000;
                          test.updateDataUser(_snapshotUser.data['uid'], {
                            'saldo': sisaSaldo,
                            'bookBlok': _snapshot.data['blok'][id],
                            'bookLantai': _snapshot.data['lantai'],
                            'bookLokasi': _snapshot.data['lokasi'],
                            'bookBlokID': id.toString(),
                          });
                          showDialog(
                              context: context,
                              child: new AlertDialog(
                                title: new Text("Success!"),
                              ));
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GenerateQR(_snapshotUser)));
                        } else {
                          showDialog(
                              context: context,
                              child: new AlertDialog(
                                title: new Text("Fail!"),
                                content: new Text("insufficient your balance!"),
                              ));
                        }
                      },
                      icon: Icon(
                        Icons.check_circle,
                        size: 50,
                        color: Colors.green,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
