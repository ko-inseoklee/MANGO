import 'package:flutter/material.dart';
import 'package:plz/view/addUserInfo.dart';
import 'package:plz/view/guide.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/landing.dart';
import 'package:plz/view/login.dart';
import 'package:plz/view/market.dart';
import 'package:plz/view/myAccount.dart';
import 'package:plz/view/nutrition.dart';
import 'package:plz/view/refrigerator.dart';
import 'package:plz/view/trade.dart';
import 'package:plz/view/settings/alarmSettings.dart';
import 'package:plz/view/settings/appSetting/appSettings.dart';
import 'package:plz/view/splash.dart';

const ADDUSERINFO = '/adduserinfo';
const HASUSERDATA = '/hasuserdata';
const LANDING = '/landing';
const LOGIN = '/login';
const GUIDE = '/guide';
const HOME = '/home';
const SPLASH = '/splash';
const APPSETTINGS = '/appsettings';
const ALARMSETTINGS = '/alarmsettings';

const REFRIGERATOR = '/refrigerator';
const MARKET = '/market';
const TRADE = '/trade';
const NUTRITION = '/nutrition';
const PROFILE = '/profile';

class routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case APPSETTINGS:
        return MaterialPageRoute(builder: (context) => settingAppPage());
      case ALARMSETTINGS:
        return MaterialPageRoute(builder: (context) => settingAlarmPage());
      case ADDUSERINFO:
        return MaterialPageRoute(builder: (context) => addUserInfoPage());
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
      case REFRIGERATOR:
        return MaterialPageRoute(builder: (context) => refrigeratorPage());
      case MARKET:
        return MaterialPageRoute(builder: (context) => marketPage());
      case TRADE:
        return MaterialPageRoute(builder: (context) => tradePage());
      case PROFILE:
        return MaterialPageRoute(builder: (context) => myPage());
      case NUTRITION:
        return MaterialPageRoute(builder: (context) => nutritionPage());
    }
  }
}
