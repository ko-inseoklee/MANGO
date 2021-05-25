import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plz/controller/authentication.dart';
import 'package:plz/model/user.dart' as me;

final userCollection = 'User';

class UserViewModel {
  Future<me.User> findUserSnapshot(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .get();
    return me.User.fromSnapshot(snapshot);
  }
}

Future<void> makeUserInformation(
    String uid,
    String name,
    DateTime creationTime,
    DateTime lastSignInTime,
    String refID,
    int refrigerationAlarm,
    bool isRefShelf,
    int frozenAlarm,
    bool isFroShelf,
    int roomTempAlarm,
    bool isRTShelf) async {
  await FirebaseFirestore.instance.collection(userCollection).doc(uid).set({
    'uid': uid,
    'name': name,
    'creation_time': creationTime,
    'last_signed_time': lastSignInTime,
    'refrigerator_id': refID,
    'refrigeration_is_shelf': isRefShelf,
    'refrigeration_shelf_life_alarm': refrigerationAlarm,
    'frozen_is_shelf': isFroShelf,
    'frozen_shelf_life_alarm': frozenAlarm,
    'room_temp_is_shelf': isRTShelf,
    'room_temp_shelf_life_alarm': roomTempAlarm,
  });
}
