import 'package:cloud_firestore/cloud_firestore.dart';

//Field name for User document.
final isFrozenAlarm = 'frozen_is_shelf';
final frozenAlarmTime = 'frozen_shelf_life_alarm';
final isRefAlarm = 'refrigeration_is_shelf';
final refAlarmTime = 'refrigeration_shelf_life_alarm';
final isRTAlarm = 'room_temp_is_shelf';
final rTAlarmTime = 'room_temp_shelf_life_alarm';

class User {
  final String userID;
  final DateTime creationTime;
  final String refrigeratorID;
  int refrigerationAlarm;
  bool isRefShelf;
  int frozenAlarm;
  bool isFroShelf;
  int roomTempAlarm;
  bool isRTShelf;
  DateTime lastSignIn;
  String profileImageReference;
  String userName;
  final DocumentReference reference;

  User(
      {this.lastSignIn,
      this.profileImageReference,
      this.refrigerationAlarm,
      this.isRefShelf,
      this.frozenAlarm,
      this.isFroShelf,
      this.roomTempAlarm,
      this.isRTShelf,
      this.userID,
      this.refrigeratorID,
      this.creationTime,
      this.userName,
      this.reference});

  User.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        userID = snapshot.id,
        userName = snapshot.data()['name'],
        profileImageReference = snapshot.data()['profile_image'],
        creationTime = DateTime.fromMicrosecondsSinceEpoch(
            snapshot.data()['creation_time'].microsecondsSinceEpoch),
        refrigeratorID = snapshot.data()['refrigerator_id'],
        isFroShelf = snapshot.data()['frozen_is_shelf'],
        frozenAlarm = snapshot.data()['frozen_shelf_life_alarm'],
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

//Field name of user collection for firebase.
