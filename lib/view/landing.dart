import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plz/view/addUserInfo.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/login.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/viewModel/authentication.dart';
import 'package:plz/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  Authentication _auth;
  Future<bool> hasData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _auth = context.watch<Authentication>();
    platform = Platform.isIOS;

    if (_auth.user == null) {
      return loginPage();
    } else {
      return FutureBuilder(
          future: _auth.hasData(_auth.user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == false) {
              return addUserInfoPage();
            } else {
              return ChangeNotifierProvider<UserViewModel>(
                create: (context) => UserViewModel(),
                child: homePage(),
              );
            }
          });
    }
  }
}
