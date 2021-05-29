import 'package:flutter/material.dart';
import 'package:plz/controller/authentication.dart';
import 'package:plz/controller/userController.dart';
import 'package:plz/model/user.dart';
import 'package:provider/provider.dart';

import 'addUserInfo.dart';
import 'home.dart';

class hasUserDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _auth = Provider.of<Authentication>(context);

    return FutureBuilder(
        future: UserViewModel().findUserSnapshot(_auth.user.uid),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData == false) {
            return addUserInfoPage();
          } else if (snapshot.hasError) {
            return Padding();
          } else {
            return homePage();
          }
        });
  }
}
