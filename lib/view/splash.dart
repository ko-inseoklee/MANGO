import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plz/routes.dart';

import 'package:flutter/src/scheduler/ticker.dart';
import '../colors.dart';

var deviceWidth = 375.0;
var deviceHeight = 812.0;
var prototypeWidth = 375.0;
var prototypeHeight = 812.0;

var platform = true;

class splashPage extends StatefulWidget {
  @override
  _splashPageState createState() => _splashPageState();
}

class _splashPageState extends State<splashPage>
    with SingleTickerProviderStateMixin {
  //TODO: for testing
  var _loginWidth = 275.0;
  var _loginHeight = 275.0;

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);
    Timer(Duration(seconds: 2),
        () => Navigator.popAndPushNamed(context, LANDING));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return FadeTransition(
      opacity: _animation,
      child: loadingAppRun(),
    );
  }

  Widget loadingAppRun() {
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
          Container(
            alignment: Alignment.center,
            width: _loginWidth * (deviceWidth / prototypeWidth),
            height: _loginHeight * (deviceWidth / prototypeWidth),
            child: CircularProgressIndicator(
              backgroundColor: MangoWhite,
            ),
          ),
          Spacer(
            flex: 4,
          ),
        ],
      )),
    );
  }
}
