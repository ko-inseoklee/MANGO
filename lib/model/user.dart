import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plz/model/userRefrigerator.dart';

class User {
  String userID;
  DateTime creationTime;
  DateTime lastSignIn;
  String userName;
  DocumentReference reference;
  String refrigeratorID;
  int refrigerationAlarm;
  bool isRefShelf;
  int frozenAlarm;
  bool isFroShelf;
  int roomTempAlarm;
  bool isRTShelf;

  User(
      {this.userID,
      this.refrigeratorID,
      this.creationTime,
      this.userName,
      this.reference});

  User.fromAuthentication(
      String uid, String uName, DateTime cTime, DateTime lSignIn) {
    this.userID = uid;
    this.userName = uName;
    this.creationTime = cTime;
    this.lastSignIn = lSignIn;
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        userID = snapshot.id,
        userName = snapshot.data()['name'],
        creationTime = snapshot.data()['creationTime'],
        refrigeratorID = snapshot.data()['refrigID'],
        reference = snapshot.reference;
}
