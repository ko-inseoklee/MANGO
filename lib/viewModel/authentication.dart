import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plz/viewModel/userViewModel.dart';
import 'package:plz/model/user.dart' as me;
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription userAuthSub;
  User user;

  Authentication() {
    _auth.authStateChanges().listen((newUser) {
      print('Authentication - FirebaseAuth - AuthStateChanged - $newUser');
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      print('Authentication - FirebaseAuth - AuthStateChanged - $e');
    });
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }

  Future<User> googleLogin() async {
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleAuthProvider);
      } else {
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final authResult = await _auth.signInWithCredential(credential);

        return authResult.user;
      }
    } catch (e) {
      print('Error reported: $e');
    }
  }

  Future<User> facebookLogin() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    final authResult = await _auth.signInWithCredential(facebookAuthCredential);

    return authResult.user;
  }

  Future<User> kakaoLogin() async {
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
        url: url.toString(), callbackUrlScheme: "webauthcallback");

    final body = Uri.parse(result).queryParameters;

    final tokenUrl = Uri.https('kauth.kakao.com', '/oauth/token', {
      'grant_type': 'authorization_code',
      'client_id': 'ae58524d5e3551dcc6608530c1e38422',
      'redirect_uri':
          'https://woolly-nosy-titanoceratops.glitch.me/callbacks/kakao/sign_in',
      'code': body['code'],
    });

    var response = await http.post(tokenUrl.toString());
    Map<String, dynamic> accessTokenResult = jsonDecode(response.body);
    var responseCustomToken = await http.post(
        "https://woolly-nosy-titanoceratops.glitch.me/callbacks/kakao/token",
        body: {"accessToken": accessTokenResult['access_token']});

    final authResult =
        await _auth.signInWithCustomToken(responseCustomToken.body);
    return authResult.user;
  }

  Future<User> naverLogin() async {
    final clientState = Uuid().v4();
    final url = Uri.https('nid.naver.com', '/oauth2.0/authorize', {
      'response_type': 'code',
      'client_id': 'AfpKO3uaxcVTKiKu8aVU',
      'response_mode': 'form_post',
      'redirect_uri':
          'https://woolly-nosy-titanoceratops.glitch.me/callbacks/naver/sign_in',
      'state': clientState,
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: "webauthcallback");

    final body = Uri.parse(result).queryParameters;

    final tokenUrl = Uri.https('nid.naver.com', '/oauth2.0/token', {
      'grant_type': 'authorization_code',
      'client_id': 'AfpKO3uaxcVTKiKu8aVU',
      'client_secret': 'J0KGCuqQvi',
      'code': body['code'],
      'state': clientState,
    });

    var response = await http.post(tokenUrl.toString());
    Map<String, dynamic> accessTokenResult = jsonDecode(response.body);
    var responseCustomToken = await http.post(
        "https://woolly-nosy-titanoceratops.glitch.me/callbacks/naver/token",
        body: {"accessToken": accessTokenResult['access_token']});

    final authResult =
        await _auth.signInWithCustomToken(responseCustomToken.body);

    return authResult.user;
  }

  Future<void> signOut() {
    try {
      _auth.signOut();
    } catch (e) {
      print('exception error: $e');
    }
  }

  Future<bool> hasData(String uid) async {
    bool result;

    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .get()
        .then((value) => result = value.exists);

    return result;
  }
}
