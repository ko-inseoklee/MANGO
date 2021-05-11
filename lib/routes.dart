import 'package:flutter/material.dart';
import 'package:plz/view/addUserInfo.dart';
import 'package:plz/view/guide.dart';
import 'package:plz/view/hasUserData.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/landing.dart';
import 'package:plz/view/login.dart';
import 'package:plz/view/splash.dart';

const ADDUSERINFO = '/adduserinfo';
const HASUSERDATA = '/hasuserdata';
const LANDING = '/landing';
const LOGIN = '/login';
const GUIDE = '/guide';
const HOME = '/home';
const SPLASH = '/splash';

class routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ADDUSERINFO:
        return MaterialPageRoute(builder: (context) => addUserInfoPage());
      case HASUSERDATA:
        return MaterialPageRoute(builder: (context) => hasUserDataPage());
      case LANDING:
        return MaterialPageRoute(builder: (context) => landingPage());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => loginPage());
      case GUIDE:
        return MaterialPageRoute(builder: (context) => guidePage());
      case HOME:
        return MaterialPageRoute(builder: (context) => homePage());
      case SPLASH:
        return MaterialPageRoute(builder: (context) => splashPage());
    }
  }
}
