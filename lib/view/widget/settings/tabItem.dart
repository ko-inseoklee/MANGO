import 'package:flutter/material.dart';

class TabItem {
  final String tabName;
  final IconData icon;
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  int _index = 0;

  Widget _page;
  TabItem({
    @required this.tabName,
    @required this.icon,
    @required Widget page,
  }) {
    _page = page;
  }

  void setIndex(int i) {
    _index = i;
  }

  Widget get page {
    return Visibility(
      //TODO: AppState.currentTab => Custom to homepage.
      // visible: _index == ,
      maintainState: true,
      child: Navigator(
        key: key,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (_) => _page);
        },
      ),
    );
  }
}
