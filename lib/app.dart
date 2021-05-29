import 'package:flutter/material.dart';
import 'package:plz/controller/authentication.dart';
import 'package:plz/controller/userController.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/landing.dart';
import 'package:plz/view/splash.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'model/user.dart';

class mangoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Authentication>(create: (_) => Authentication()),
        // StreamProvider<User>(create: (_) => UserViewModel().user),
      ],
      child: MaterialApp(
        title: 'Mango - manage dietary life',
        home: landingPage(),
        initialRoute: SPLASH,
        theme: _mangoTheme,
        onGenerateRoute: routers.generateRoute,
      ),
    );
  }
}

final ThemeData _mangoTheme = _buildMangoTheme();

ThemeData _buildMangoTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    accentColor: Orange400,
    primaryColor: MangoWhite,
    unselectedWidgetColor: MangoDisabledColor,
    focusColor: Orange200,
    hoverColor: Orange400,
    errorColor: MangoErrorColor,
    cursorColor: Orange400,
    buttonTheme: base.buttonTheme.copyWith(
        buttonColor: MangoDisabledColor,
        colorScheme: base.colorScheme.copyWith(secondary: Orange400)),
    colorScheme: ColorScheme.light().copyWith(primary: Orange500),
    textTheme: _buildMangoTextTheme(base.textTheme),
    primaryTextTheme: _buildMangoTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildMangoTextTheme(base.accentTextTheme),
    iconTheme: base.iconTheme.copyWith(color: MangoBlack),
    primaryIconTheme: base.iconTheme.copyWith(color: MangoBlack),
  );
}

TextTheme _buildMangoTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline1: base.headline1.copyWith(
          fontSize: 96.0,
          fontWeight: FontWeight.w300,
        ),
        headline2: base.headline2.copyWith(
          fontSize: 60.0,
          fontWeight: FontWeight.w300,
        ),
        headline3: base.headline3.copyWith(
          fontSize: 40.0,
          fontWeight: FontWeight.w400,
        ),
        /* headline4: dialog title*/
        headline4: base.headline4.copyWith(
          fontSize: 34.0,
          fontWeight: FontWeight.w400,
        ),
        /* headline5: hintText of ProfilePage(subtitle 2_KR)*/
        headline5: base.headline5.copyWith(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
        ),
        /* headline6: Text of AppBar */
        headline6: base.headline6.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
        subtitle1: base.subtitle1.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
        /* subtitle2: substitle of ListTile*/
        subtitle2: base.subtitle2.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        /* bodyText2: dialog text */
        bodyText2: base.button.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        /* button: all of button + tabs */
        button: base.button.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        caption: base.caption.copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
        overline: base.caption.copyWith(
          fontSize: 10.0,
          fontWeight: FontWeight.w500,
        ),
      )
      .apply(
          fontFamily: 'NotoSansKR',
          bodyColor: Colors.black,
          displayColor: Colors.black);
}
