import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:plz/model/user.dart' as me;

final userCollection = 'User';

class UserViewModel extends ChangeNotifier {
  me.User user;

  UserViewModel({this.user});

  String get uid => this.user.userID;

  set refAlarm(int value) {
    this.user.refrigerationAlarm = value;
    notifyListeners();
  }

  set rTAlarm(int value) {
    this.user.roomTempAlarm = value;
    notifyListeners();
  }

  set frozenAlarm(int value) {
    this.user.frozenAlarm = value;
    notifyListeners();
  }

  Future<void> findUserSnapshot(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .get();
    this.user = me.User.fromSnapshot(snapshot);
    notifyListeners();
  }

  Future<void> deleteUser({String uid}) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .delete()
        .then((value) => print("delete success"));
  }
}

Future<void> makeUserInformation(
    String uid,
    String name,
    String profileImage,
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
    'profile_image': profileImage,
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
