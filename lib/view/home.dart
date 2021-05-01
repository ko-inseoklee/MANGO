import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plz/model/user.dart';
import 'package:plz/view/guide.dart';
import 'package:plz/viewModel//authentication.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/landing.dart';
import 'package:plz/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

import 'addUserInfo.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context);
    //Example of updating stream

    if (_user.creationTime != null) {
      Provider<User>.value(
          value: User.fromSnapshot(findUserSnapshot(_user.userID)));

      print(_user.userID);

      return Center(
          child: RaisedButton(
              child: Text('Sign out'),
              onPressed: () async {
                await Authentication().signOut();
                Navigator.popAndPushNamed(context, LANDING);
              }));
    } else {
      return addUserInfoPage();
    }
  }
}
