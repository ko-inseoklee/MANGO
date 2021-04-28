import 'package:flutter/material.dart';
import 'package:plz/view/landing.dart';

import '../routes.dart';

class addUserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('add user info page'),
            RaisedButton(
              onPressed: () async {
                // await addUser(auth.currentUser.uid);
                Navigator.popAndPushNamed(context, LANDING);
              },
              child: Text('회원가입'),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> addUser(String documentID) {
  //   return userCollection
  //       .doc(documentID)
  //       .set({'userID': documentID, 'refrigID': '1234', 'userName': '이인석'})
  //       .then((value) => print('회원가입이 정상적으로 완료되었습니다.'))
  //       .catchError((error) => print('error occured.'));
  // }
}
