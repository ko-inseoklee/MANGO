import 'package:flutter/material.dart';
import 'package:plz/login.dart';
import 'home.dart';

final LOGIN = 'login';
final HOME = 'home';

class mangoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mango - manage dietary life',
      home: homePage(),
      initialRoute: LOGIN,
      routes: {
        LOGIN: (context) => loginPage(),
        HOME: (context) => homePage(),
      },
    );
  }
}
