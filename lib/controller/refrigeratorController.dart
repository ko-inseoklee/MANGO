import 'package:cloud_firestore/cloud_firestore.dart';

String refrigeratorCollection = "Refrigerator";

class refrigeratorController {
  final String refrigeratorID = "refrigerator_id";

  Stream<DocumentSnapshot> getUser(String refID) {
    var stream = FirebaseFirestore.instance
        .collection(refrigeratorCollection)
        .doc(refID)
        .get()
        .asStream();
    return stream;
  }

  Future<void> makeRefInfoDocument({String refID}) async {
    await FirebaseFirestore.instance
        .collection(refrigeratorCollection)
        .doc(refID)
        .set({
      refrigeratorID: refID,
    });
  }
}
