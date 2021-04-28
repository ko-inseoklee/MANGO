import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:plz/colors.dart';
import 'package:plz/viewModel/authentication.dart';
import 'package:plz/view/splash.dart';

import '../routes.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('first initstate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('first dispose');
  }

  @override
  Widget build(BuildContext context) {
    print('first page');
    Authentication().printCurrentUser();
    return Scaffold(
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
                    color: Colors.white,
                    onPressed: () async {
                      await Authentication().googleLogin().then(
                          (value) => Navigator.popAndPushNamed(context, HOME));
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
                      await Authentication().facebookLogin().then(
                          (value) => Navigator.popAndPushNamed(context, HOME));
                      Navigator.popAndPushNamed(context, HOME);
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
                      await Authentication().kakaoLogin().then(
                          (value) => Navigator.popAndPushNamed(context, HOME));
                      // Origin
                      // await Authentication().kakaoLogin().then(
                      //         (value) => Navigator.popAndPushNamed(context, HOME));
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
                      await Authentication().naverLogin().then(
                          (value) => Navigator.popAndPushNamed(context, HOME));
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
