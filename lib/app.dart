import 'package:flutter/material.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/login.dart';
import 'view/home.dart';

class mangoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mango - manage dietary life',
      home: homePage(),
      initialRoute: LANDING,
      onGenerateRoute: routers.generateRoute,
    );
  }
}
