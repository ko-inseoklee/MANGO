import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userID;
  int refrigID;
  DateTime creationTime;
  String userName;

  //uName: user_name, cTime: creation_time
  User({String uid, String uName, DateTime cTime}) {
    userID = uid;
    userName = uName;
    creationTime = cTime;
  }
}
