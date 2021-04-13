import 'package:flutter/material.dart';
import 'package:plz/app.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/login.dart';

const LANDING = 'landing';
const LOGIN = 'login';
const HOME = 'home';

class routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (context) => homePage());
      default:
        return MaterialPageRoute(builder: (context) => loginPage());
    }
  }
}
