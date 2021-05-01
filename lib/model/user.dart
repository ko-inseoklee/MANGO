import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plz/model/userRefrigerator.dart';

class User {
  String userID;
  DateTime creationTime;
  String userName;
  DocumentReference reference;
  String refrigeratorID;

  User(
      {this.userID,
      this.refrigeratorID,
      this.creationTime,
      this.userName,
      this.reference});

  User.fromAuthentication(String uid, String uName, DateTime cTime) {
    this.userID = uid;
    this.userName = uName;
    this.creationTime = cTime;
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        userID = snapshot.id,
        userName = snapshot.data()['userName'],
        creationTime = snapshot.data()['creationTime'],
        refrigeratorID = snapshot.data()['refrigID'],
        reference = snapshot.reference;
}
