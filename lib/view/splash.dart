import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:plz/view/guide.dart';
import 'package:plz/view/landing.dart';

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

class _splashPageState extends State<splashPage> {
  //TODO: for testing
  void _reset() async {
    await IsFirstRun.reset();
  }

  bool _isFirstRun = true;
  var _loginWidth = 275.0;
  var _loginHeight = 275.0;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: isFirstRun(),
        builder: (BuildContext context, AsyncSnapshot snapshots) {
          IsFirstRun.reset();
          if (snapshots.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshots.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          }
          if (snapshots.hasData) {
            return _isFirstRun ? guidePage() : landingPage();
          }
          return loadingAppRun();
        });
  }

  Future<bool> isFirstRun() async {
    bool _temp = await IsFirstRun.isFirstRun();

    setState(() {
      _isFirstRun = _temp;
    });
    return _isFirstRun;
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
          Container(
            alignment: Alignment.center,
            width: _loginWidth * (deviceWidth / prototypeWidth),
            height: _loginHeight * (deviceWidth / prototypeWidth),
            child: CircularProgressIndicator(
              backgroundColor: White,
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
