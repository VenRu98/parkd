import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {
  bool isLogIn() {
    
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  // Future getUser()async{
  //   FirebaseUser user=await FirebaseAuth.instance.currentUser();
  //   return user;
  // }
  Future<DocumentSnapshot> getUser(FirebaseUser user) async {
    var test = Firestore.instance.collection('users').document(user.uid).get();
    return test;
  }
  Future<DocumentSnapshot> getDenah(String lantai) async {
    var test = Firestore.instance.collection('denahParkirUKM').document(lantai).get();
    return test;
  }

  Future<void> addDataUser(userData, String uid) async {
    if (isLogIn()) {
      Firestore.instance.runTransaction((Transaction crudTransaction) async {
        DocumentReference reference =
            await Firestore.instance.collection('users').document(uid);
          
        reference.setData(userData);
      });
    }
  }

  Future<void> addDenah() async {
    if (isLogIn()) {
      List array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"];
      String lantai = "B1";
      List isiBlock=[];
      List boolBlock=[];
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 6; j++) {
          isiBlock.add(array[i] + (j + 1).toString());
          boolBlock.add(false);
        }
      }
      DocumentReference reference = await Firestore.instance
          .collection('denahParkirUKM')
          .document('blok$lantai');
      reference.setData({
        'lokasi': 'Universitas Kristen Maranatha',
        'lantai': '$lantai',
        'blok': isiBlock,
        'kondisi': boolBlock,
      });
    }
  }

  updateDenah(selectedDoc, newValues)async{
    Firestore.instance.collection('denahParkirUKM').document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });
  }

  updateDataUser(selectedDoc, newValues)async{
    Firestore.instance.collection('users').document(selectedDoc).updateData(newValues).catchError((e){
      print(e);
    });
  }

  // Future<Map> getDataUser(String uid)async{
  //   if(isLogIn()){
  //     Firestore.instance.collection('users').document(uid).snapshots();
  //   }
  //   return "";
  // }
}
