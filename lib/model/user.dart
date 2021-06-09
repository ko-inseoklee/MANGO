import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plz/model/userRefrigerator.dart';

class User {
  String userID;
  DateTime creationTime;
  DateTime lastSignIn;
  String profileImageReference;
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
        creationTime = DateTime.fromMicrosecondsSinceEpoch(
            snapshot.data()['creation_time'].microsecondsSinceEpoch),
        refrigeratorID = snapshot.data()['refrigerator_id'],
        isFroShelf = snapshot.data()['frozen_is_shelf'],
        frozenAlarm = snapshot.data()['frozen_shelf_life_alarm'],
        profileImageReference = snapshot.data()['profile_image'],
        lastSignIn = DateTime.fromMicrosecondsSinceEpoch(
            snapshot.data()['last_signed_time'].microsecondsSinceEpoch),
        isRefShelf = snapshot.data()['refrigeration_is_shelf'],
        refrigerationAlarm = snapshot.data()['refrigeration_shelf_life_alarm'],
        isRTShelf = snapshot.data()['room_temp_is_shelf'],
        roomTempAlarm = snapshot.data()['room_temp_shelf_life_alarm'],
        reference = snapshot.reference;
}

final userCollection = 'User';

class user {
  String uid;

  user({this.uid});

  Stream<DocumentSnapshot> get snapshot => FirebaseFirestore.instance
      .collection(userCollection)
      .doc(uid)
      .get()
      .asStream();

  Stream<DocumentSnapshot> getUser(String uid) {
    var stream = FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .get()
        .asStream();
    return stream;
  }
}
