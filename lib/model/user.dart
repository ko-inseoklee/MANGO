import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userID;
  int refrigID;
  DateTime creationTime;
  String userName;
  DocumentReference reference;

  User({String uid, DateTime cTime}) {
    userID = uid;
    creationTime = cTime;
  }
}
