import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plz/model/user.dart';
import 'package:plz/view/addUserInfo.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/login.dart';

var deviceWidth = 375.0;
var deviceHeight = 812.0;
var prototypeWidth = 375.0;
var prototypeHeight = 812.0;

var platform = true;

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference userCollection =
    FirebaseFirestore.instance.collection('User');

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  bool userExist = false;

  @override
  Widget build(BuildContext context) {
    platform = Platform.isIOS;

    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          return auth.currentUser == null
              ? loginPage()
              : FutureBuilder(
                  future: checkDocExists(auth.currentUser.uid),
                  builder: (context, snapshot) {
                    return !userExist ? addUserInfoPage() : homePage();
                  });
        });
  }

  checkDocExists(String docID) async {
    DocumentSnapshot doc = await userCollection.doc(docID).get();
    userExist = doc.exists;
  }
}
