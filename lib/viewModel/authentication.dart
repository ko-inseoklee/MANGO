import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plz/model/user.dart' as me;
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  me.User _userFromFirebase(User user) {
    // If the difference of creationTime exceed the maxAccessingTime(minutes), It regards Signed-in before.
    int maxAccessingTime = 10;

    if (user != null) {
      var _firstCreation = user.metadata.creationTime;
      bool _isfirst = DateTime.now().difference(_firstCreation).inMinutes <=
              maxAccessingTime
          ? true
          : false;
      return _isfirst
          ? me.User.fromAuthentication(user.uid, user.displayName, null)
          : me.User.fromAuthentication(
              user.uid, user.displayName, user.metadata.creationTime);
    } else {
      return null;
    }
  }

  Stream<me.User> get user => _auth.authStateChanges().map(_userFromFirebase);

  Future<void> googleLogin() async {
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

        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      print('Error reported: $e');
    }
  }

  Future<UserCredential> facebookLogin() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> kakaoLogin() async {
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

    return await _auth.signInWithCustomToken(responseCustomToken.body);
  }

  Future<UserCredential> naverLogin() async {
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

    return await _auth.signInWithCustomToken(responseCustomToken.body);
  }

  Future<void> signOut() {
    _auth.signOut();
  }

  Future<bool> isFirstSignin(String documentID) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('User')
        .doc(documentID)
        .get();
    return doc.exists;
  }

  void printCurrentUser() {
    print(_auth.currentUser);
  }
}
