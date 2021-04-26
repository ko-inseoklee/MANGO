import 'dart:convert';
import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:plz/colors.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/landing.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 40,
          ),
          Container(
            child: Text(
              '당신의 냉장고를 관리해주는 집요정,',
              style:
                  Theme.of(context).textTheme.subtitle1.copyWith(color: White),
            ),
          ),
          Spacer(
            flex: 5,
          ),
          Container(
            child: Image.asset('images/login/appName.png'),
          ),
          Spacer(
            flex: 5,
          ),
          Container(
            child: Text(
              'Manager + 古',
              style: Theme.of(context).textTheme.caption.copyWith(color: White),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Image(
            image: AssetImage('images/login/logo.png'),
            height: 140,
            fit: BoxFit.contain,
          ),
          Spacer(
            flex: 2,
          ),
          loginMethodWidget(platform),
          Spacer(
            flex: 2,
          ),
        ],
      )),
    );
  }

  Widget loginMethodWidget(bool isIOS) {
    var loginWidth = 275.0;
    var loginHeight = 275.0;

    var logoSize = 25.0;
    var buttonHeightRatio = 1.4;
    var borderRatio = 5.0;

    return Container(
        alignment: Alignment.center,
        width: loginWidth * (deviceWidth / prototypeWidth),
        height: loginHeight * (deviceWidth / prototypeWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonTheme(
                minWidth: loginWidth * (deviceWidth / prototypeWidth),
                height: logoSize *
                    (deviceWidth / prototypeWidth) *
                    buttonHeightRatio,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRatio)),
                child: FlatButton(
                    color: Colors.white,
                    onPressed: () async {
                      await _googleLogin(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage('images/login/google_logo.png'),
                          width: logoSize * (deviceWidth / prototypeWidth),
                          height: logoSize * (deviceWidth / prototypeWidth),
                        ),
                        Text(
                          '구글 계정으로 시작하기',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ))),
            ButtonTheme(
                minWidth: loginWidth * (deviceWidth / prototypeWidth),
                height: logoSize *
                    (deviceWidth / prototypeWidth) *
                    buttonHeightRatio,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRatio)),
                child: FlatButton(
                    color: Colors.white,
                    onPressed: () async {
                      await _facebookLogin();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage('images/login/facebook_logo.png'),
                          width: logoSize * (deviceWidth / prototypeWidth),
                          height: logoSize * (deviceWidth / prototypeWidth),
                        ),
                        Text(
                          '페이스북 계정으로 시작하기',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ))),
            ButtonTheme(
                minWidth: loginWidth * (deviceWidth / prototypeWidth),
                height: logoSize *
                    (deviceWidth / prototypeWidth) *
                    buttonHeightRatio,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRatio)),
                child: FlatButton(
                    color: Colors.white,
                    onPressed: () async {
                      await _kakaoLogin();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage('images/login/kakao_logo.png'),
                          width: logoSize * (deviceWidth / prototypeWidth),
                          height: logoSize * (deviceWidth / prototypeWidth),
                        ),
                        Text(
                          '카카오 계정으로 시작하기',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ))),
            ButtonTheme(
                minWidth: loginWidth * (deviceWidth / prototypeWidth),
                height: logoSize *
                    (deviceWidth / prototypeWidth) *
                    buttonHeightRatio,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRatio)),
                child: FlatButton(
                    color: Colors.white,
                    onPressed: () async {
                      await _naverLogin();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage('images/login/naver_logo.png'),
                          width: logoSize * (deviceWidth / prototypeWidth),
                          height: logoSize * (deviceWidth / prototypeWidth),
                        ),
                        Text(
                          '네이버 계정으로 시작하기',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ))),
            io.Platform.isIOS
                ? ButtonTheme(
                    child: RaisedButton.icon(
                        onPressed: () async {
                          await _naverLogin();
                        },
                        icon: Icon(Icons.account_box),
                        label: Text('애플 계정으로 시작하기')))
                : Text(' '),
          ],
        ));
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

    return await FirebaseAuth.instance
        .signInWithCustomToken(responseCustomToken.body);
  }

  Future<UserCredential> _naverLogin() async {
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

    return await FirebaseAuth.instance
        .signInWithCustomToken(responseCustomToken.body);
  }
}
