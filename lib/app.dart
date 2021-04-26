import 'package:flutter/material.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/login.dart';
import 'colors.dart';
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

final ThemeData _mangoTheme = _buildMangoTheme();

ThemeData _buildMangoTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      accentColor: Orange400,
      primaryColor: White,
      hoverColor: Orange400,
      errorColor: Red500,
      cursorColor: Orange400,
      buttonTheme: base.buttonTheme.copyWith(
          buttonColor: DisabledColor,
          colorScheme: base.colorScheme.copyWith(secondary: Orange400)),
      colorScheme: ColorScheme.light().copyWith(primary: Orange500));
}
