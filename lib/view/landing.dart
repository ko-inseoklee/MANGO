import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plz/model/user.dart';
import 'package:plz/view/addUserInfo.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/login.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference userCollection =
    FirebaseFirestore.instance.collection('User');

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  var returnPage;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (auth.currentUser == null) {
            returnPage = loginPage();
          } else {
            print('uid== ${auth.currentUser.uid}');
            userCollection.doc(auth.currentUser.uid).get().then((document) {
              if (document.exists) {
                returnPage = homePage();
              } else {
                returnPage = addUserInfoPage();
              }
            });
          }
          return returnPage ?? loginPage();
        });
  }
}
