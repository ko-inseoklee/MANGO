import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userID;
  int refrigID;
  String userName;
  DocumentReference reference;

  User({String uid}) {
    userID = uid;
  }
}
