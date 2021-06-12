import 'dart:typed_data';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plz/view/market.dart';
import 'package:plz/view/myAccount.dart';
import 'package:plz/view/nutrition.dart';
import 'package:plz/view/refrigerator.dart';
import 'package:plz/view/trade.dart';
import 'package:plz/view/widget/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:plz/view/widget/bottomNavigationBar/tabItem.dart';
import 'package:plz/view/widget/dialog/dialog.dart';

class homePage extends StatefulWidget {
  @override
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage> {
  static int currentTab = 0;

  final List<TabItem> tabs = [
    TabItem(
        tabName: "냉장고",
        icon: Icons.kitchen_outlined,
        page: refrigeratorPage(
          title: "냉장고",
        )),
    TabItem(
        tabName: "마켓",
        icon: Icons.shopping_cart_outlined,
        page: marketPage(
          title: "마켓",
        )),
    TabItem(
        tabName: "거래광장",
        icon: Icons.local_mall_outlined,
        page: tradePage(
          title: "거래광장",
        )),
    TabItem(
        tabName: "냉장고 분석",
        icon: Icons.fact_check_outlined,
        page: nutritionPage(
          title: "냉장고 분석",
        )),
    TabItem(
        tabName: "마이 페이지",
        icon: Icons.account_box_outlined,
        page: myPage(
          title: "마이 페이지",
        ))
  ];

  homePageState() {
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  void _selectTab(int index) {
    if (index == currentTab) {
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => currentTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await tabs[currentTab].key.currentState.maybePop();
          if (isFirstRouteInCurrentTab) {
            if (currentTab != 0) {
              _selectTab(0);
              return false;
            }
          }
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: IndexedStack(
            index: currentTab,
            children: tabs.map((e) => e.page).toList(),
          ),
          bottomNavigationBar: bottomNavigationBar(
            onSelectTab: _selectTab,
            tabs: tabs,
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                comingSoon(context);
              },
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(Icons.add)),
        ));
  }
}
