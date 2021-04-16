import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/login.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          print(snapshot);
          return auth.currentUser == null ? loginPage() : homePage();
        });
  }
}
