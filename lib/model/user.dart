import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  final String userID;
  final int refrigID;
  String userName;
  final DocumentReference reference;

  user.fromSnapshot(DocumentSnapshot snapshot)
      : assert(snapshot != null),
        userID = snapshot.id,
        refrigID = snapshot.data()['refrigID'],
        reference = snapshot.reference;
}
