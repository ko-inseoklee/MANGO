import 'package:flutter/material.dart';
import 'package:plz/colors.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/widget/bottomNavigationBar/tabItem.dart';

import '../../splash.dart';

class bottomNavigationBar extends StatelessWidget {
  bottomNavigationBar({this.onSelectTab, this.tabs});
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: tabs
          .map((tab) => _buildBottomTab(
              index: tab.getIndex(), icon: tab.icon, tabName: tab.tabName))
          .toList(),
      onTap: (index) => onSelectTab(index),
    );
  }

  BottomNavigationBarItem _buildBottomTab(
      {int index, IconData icon, String tabName}) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _tabColor(index: index),
        ),
        title: Text(
          tabName,
          style: TextStyle(color: MangoBlack),
        ));
  }

  Color _tabColor({int index}) {
    return Home2State.currentTab == index ? Orange400 : MangoDisabledColor;
  }
}
