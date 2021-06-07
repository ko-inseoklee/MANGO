import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:plz/colors.dart';
import 'package:plz/controller/authentication.dart';
import 'package:plz/controller/userController.dart';
import 'package:plz/view/market.dart';
import 'package:plz/view/myAccount.dart';
import 'package:plz/view/nutrition.dart';
import 'package:plz/view/refrigerator.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/view/trade.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

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
      child: Scaffold(
        backgroundColor: MangoWhite,
        appBar: AppBar(
          title: Text(_items[selectedIdx].itemName),
          centerTitle: true,
        ),
        body: pages[selectedIdx],
        bottomNavigationBar: bottomAppbar(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.add)),
      ),
    );
  }

  List<Widget> pages = [
    refrigeratorPage(),
    marketPage(),
    tradePage(),
    nutritionPage(),
    myPage()
  ];

  int selectedIdx = 0;

  List<bottomItem> _items = [
    bottomItem(
        idx: 0,
        itemName: '냉장고',
        iconData: Icons.kitchen_rounded,
        navRef: REFRIGERATOR),
    bottomItem(
        idx: 1,
        itemName: '마켓',
        iconData: Icons.shopping_cart_rounded,
        navRef: MARKET),
    bottomItem(
        idx: 2,
        itemName: '거래광장',
        iconData: Icons.local_mall_rounded,
        navRef: TRADE),
    bottomItem(
        idx: 3,
        itemName: '냉장고 분석',
        iconData: Icons.fact_check_rounded,
        navRef: NUTRITION),
    bottomItem(
        idx: 4,
        itemName: '마이 페이지',
        iconData: Icons.account_box_rounded,
        navRef: PROFILE),
  ];

  Widget bottomAppbar() {
    return BottomAppBar(
      // color: Colors.pink,
      child: Container(
        height: 70 * deviceHeight / prototypeHeight,
        child: Row(
          children: _buildBottomItems(context),
        ),
      ),
    );
  }

  _buildBottomItems(BuildContext context) {
    return _items.map((item) {
      return Container(
          width: 75 * (deviceWidth / prototypeWidth),
          child: FlatButton(
            onPressed: () {
              setState(() {
                selectedIdx = item.idx;
                print(selectedIdx);
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.iconData,
                  size: 24,
                  color: item.idx == selectedIdx
                      ? Theme.of(context).accentColor
                      : Theme.of(context).buttonColor,
                ),
                FittedBox(fit: BoxFit.fitWidth, child: Text(item.itemName))
              ],
            ),
          ));
    }).toList();
  }
}

class bottomItem {
  @required
  int idx;
  @required
  String itemName;
  @required
  IconData iconData;
  @required
  String navRef;

  bottomItem({this.itemName, this.iconData, this.navRef, this.idx});
}
