import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:plz/routes.dart';
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
        child: Column(
          children: [
            ButtonTheme(
              child: RaisedButton.icon(
                  onPressed: () async {
                    await _googleLogin(context);
                  },
                  icon: Icon(Icons.account_box),
                  label: Text('구글 계정으로 시작하기')),
            ),
            ButtonTheme(
              child: RaisedButton.icon(
                  onPressed: () async {
                    await _facebookLogin();
                    print('facebook id === ${auth.currentUser}');
                  },
                  icon: Icon(Icons.account_box),
                  label: Text('페이스북 계으로 시작하기')),
            )
          ],
        ),
      ),
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

  Future<UserCredential> _facebookLogin() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
  }
}
