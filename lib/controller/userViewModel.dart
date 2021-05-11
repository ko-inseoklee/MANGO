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

Future<void> makeUserInformation(String uid, String name, DateTime creationTime,
    DateTime lastSignInTime) async {
  await FirebaseFirestore.instance.collection(userCollection).doc(uid).set({
    'uid': uid,
    'name': name,
    'creation_time': creationTime,
    'last_signed_time': lastSignInTime
  });
}
