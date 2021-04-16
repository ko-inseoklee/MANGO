import 'package:flutter/material.dart';
import 'package:plz/app.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/landing.dart';
import 'package:plz/view/login.dart';

const LANDING = '/landing';
const LOGIN = '/login';
const HOME = '/home';

class routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LANDING:
        return MaterialPageRoute(builder: (context) => landingPage());
      case LOGIN:
        return MaterialPageRoute(builder: (context) => loginPage());
      case HOME:
        return MaterialPageRoute(builder: (context) => homePage());
    }
  }
}
