import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:plz/view/landing.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ButtonTheme(
        child: RaisedButton.icon(
            onPressed: () async {
              _googleLogin(context);
            },
            icon: Icon(Icons.account_box),
            label: Text('구글 계정으로 시작하기')),
      )),
    );
  }

  Future<void> _googleLogin(BuildContext context) async {
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        userCredential = await auth.signInWithPopup(googleAuthProvider);
      } else {
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        return await auth.signInWithCredential(credential);
      }
    } catch (e) {
      print('Error reported: $e');
    }
  }
}
