import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:plz/controller/authentication.dart';
import 'package:plz/controller/userController.dart';
import 'package:plz/model/user.dart';
import 'package:plz/view/market.dart';
import 'package:plz/view/myAccount.dart';
import 'package:plz/view/nutrition.dart';
import 'package:plz/view/refrigerator.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/view/trade.dart';
import 'package:provider/provider.dart';

import '../routes.dart';
import 'addUserInfo.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Widget> _screenList = [
    refrigeratorPage(),
    marketPage(),
    tradePage(),
    nutritionPage(),
    myPage()
  ];

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

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
    var _user = Provider.of<Authentication>(context);

    return StreamProvider<DocumentSnapshot>(
      create: (_) => UserViewModel().getUser(_user.user.uid),
      child: PersistentTabView(
        context,
        screens: _screenList,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.add)),
        resizeToAvoidBottomInset: false,
        items: _navBarItems(),
        navBarHeight: 84 * deviceHeight / prototypeHeight,
        navBarStyle: NavBarStyle.style3,
        controller: _controller,
      ),
    );

    // return Center(
    //     child: RaisedButton(
    //         child: Text('Sign out'),
    //         onPressed: () async {
    //           await Authentication().signOut();
    //           Navigator.popAndPushNamed(context, LANDING);
    //         }));
  }

  List<String> _navBarTitle = ['냉장고', '마켓', '거래광장', '냉장고 분석', '마이페이지'];
  List<Icon> _navBarIcon = [
    Icon(Icons.kitchen_rounded),
    Icon(Icons.shopping_cart_rounded),
    Icon(Icons.local_mall_rounded),
    Icon(Icons.fact_check_rounded),
    Icon(Icons.account_box_rounded)
  ];

  List<PersistentBottomNavBarItem> _navBarItems() {
    List<PersistentBottomNavBarItem> result = [];
    for (int i = 0; i < _navBarIcon.length; i++) {
      var item = PersistentBottomNavBarItem(
          icon: _navBarIcon[i],
          iconSize: 26 * deviceWidth / prototypeWidth,
          title: _navBarTitle[i],
          activeColorPrimary: Theme.of(context).accentColor,
          inactiveColorPrimary: Theme.of(context).disabledColor);
      result.add(item);
    }

    return result;
  }
}
