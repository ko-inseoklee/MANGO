import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/landing.dart';
import 'package:uuid/uuid.dart';

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
                  },
                  icon: Icon(Icons.account_box),
                  label: Text('페이스북 계정으로 시작하기')),
            ),
            ButtonTheme(
              child: RaisedButton.icon(
                  onPressed: () async {
                    await _kakaoLogin();
                    print('facebook id === ${auth.currentUser}');
                  },
                  icon: Icon(Icons.account_box),
                  label: Text('카카오 계정으로 시작하기')),
            ),
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

  Future<UserCredential> _kakaoLogin() async {
    final clientState = Uuid().v4();
    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': 'code',
      'client_id': 'ae58524d5e3551dcc6608530c1e38422',
      'response_mode': 'form_post',
      'redirect_uri':
          'https://woolly-nosy-titanoceratops.glitch.me/callbacks/kakao/sign_in',
      'state': clientState,
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: "webuthcallback");

    final body = Uri.parse(result).queryParameters;

    print(body);

    final tokenUrl = Uri.https('kauth.kakao.com', '/oauth/token', {
      'grant_type': 'authorization_code',
      'client_id': 'ae58524d5e3551dcc6608530c1e38422',
      'redirect_uri':
          'https://woolly-nosy-titanoceratops.glitch.me/callbacks/kakao/sign_in',
      'code': body['code'],
    });
  }
}
