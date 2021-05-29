import 'dart:io' as io;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plz/colors.dart';
import 'package:plz/controller/authentication.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/controller/userController.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  Authentication _auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<Authentication>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 20,
          ),
          Container(
            child: Text(
              '당신의 냉장고를 관리해주는 집요정,',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: MangoWhite),
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
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: MangoWhite),
            ),
          ),
          Spacer(
            flex: 4,
          ),
          Image(
            image: AssetImage('images/login/logo.png'),
            height: 140,
            fit: BoxFit.contain,
          ),
          Spacer(
            flex: 4,
          ),
          loginMethodWidget(platform),
          Spacer(
            flex: 4,
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
                    color: MangoWhite,
                    onPressed: () async {
                      _auth.user = await Authentication().googleLogin();
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
                    color: MangoWhite,
                    onPressed: () async {
                      _auth.user = await Authentication().facebookLogin();
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
                    color: MangoWhite,
                    onPressed: () async {
                      _auth.user = await Authentication().kakaoLogin();
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
                    color: MangoWhite,
                    onPressed: () async {
                      _auth.user = await Authentication().naverLogin();
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
                          await Authentication().naverLogin();
                        },
                        icon: Icon(Icons.account_box),
                        label: Text('애플 계정으로 시작하기')))
                : Text(' '),
          ],
        ));
  }
}
