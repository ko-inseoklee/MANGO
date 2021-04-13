import 'package:flutter/material.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/landing.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
            child: Text('Sign out'),
            onPressed: () async {
              await auth.signOut();
              Navigator.popAndPushNamed(context, LANDING);
            }));
  }
}
