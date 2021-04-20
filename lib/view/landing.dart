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
  bool userExist = false;

  @override
  Widget build(BuildContext context) {
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
    print('userExist == $userExist');
  }
}
