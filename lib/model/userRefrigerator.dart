import 'package:cloud_firestore/cloud_firestore.dart';

String refrigeratorCollection = 'Refrigerator';

class UserRefrigerator {
  final String refrigeratorID;

  UserRefrigerator({this.refrigeratorID});

  Stream<DocumentSnapshot> get snapshot => FirebaseFirestore.instance
      .collection(refrigeratorCollection)
      .doc(refrigeratorID)
      .get()
      .asStream();
}
