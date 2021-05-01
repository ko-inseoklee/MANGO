import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plz/model/user.dart';

final userCollection = 'User';

class UserViewModel {}

findUserSnapshot(String uid) {
  FirebaseFirestore.instance
      .collection(userCollection)
      .doc(uid)
      .get()
      .then((DocumentSnapshot snapshot) {
    return User.fromSnapshot(snapshot);
  });
}
