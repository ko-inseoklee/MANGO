import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plz/model/user.dart' as me;
import 'package:plz/view/addUserInfo.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/login.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/viewModel/authentication.dart';
import 'package:provider/provider.dart';

// Comment: Back-up ver
// FirebaseAuth auth = FirebaseAuth.instance;
// CollectionReference userCollection =
//     FirebaseFirestore.instance.collection('User');

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  @override
  Widget build(BuildContext context) {
    platform = Platform.isIOS;
    var _user = Provider.of<me.User>(context);

    return _user == null ? loginPage() : homePage();
  }

  // checkDocExists(String docID) async {
  //   DocumentSnapshot doc = await userCollection.doc(docID).get();
  //   userExist = doc.exists;
  // }
}
