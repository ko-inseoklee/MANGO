import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plz/colors.dart';
import 'package:plz/model/user.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/view/widget/settings/appSettings.dart';
import 'package:provider/provider.dart';

class myPage extends StatefulWidget {
  @override
  _myPageState createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    // DocumentSnapshot _documentSnapshot = Provider.of<DocumentSnapshot>(context);
    // User _user = new User.fromSnapshot(_documentSnapshot);

    return Consumer<DocumentSnapshot>(
        builder: (context, documentSnapshot, child) {
      if (documentSnapshot == null) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Container(
                  height: 130 * deviceHeight / prototypeHeight,
                  child: Row(
                    children: [
                      //TODO: should change the case of false condition with get image from firebase storage. Should change Using Stack for modify image button.
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            35 * deviceWidth / prototypeWidth,
                            5 * deviceWidth / prototypeWidth,
                            0,
                            5 * deviceWidth / prototypeWidth),
                        child: Container(
                          width: 60 * deviceWidth / prototypeWidth,
                          height: 60 * deviceWidth / prototypeWidth,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: documentSnapshot.data()['profile_image'] ==
                                      '-1'
                                  ? AssetImage('images/default_profile.png')
                                  : AssetImage('images/default_profile.png'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 16.0 * deviceWidth / prototypeWidth),
                        child: Text(
                          documentSnapshot.data()['name'],
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 7 * deviceHeight / prototypeHeight,
                  color: MangoBehindColor,
                ),
                Container(
                  padding: EdgeInsets.all(5.0 * deviceWidth / prototypeWidth),
                  height: 250 * deviceHeight / prototypeHeight,
                  child: Center(
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: _buildGridMenu(),
                    ),
                  ),
                ),
                Container(
                  height: 7 * deviceHeight / prototypeHeight,
                  color: MangoBehindColor,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(
                        7 * deviceWidth / prototypeWidth,
                        0,
                        7 * deviceWidth / prototypeWidth,
                        0),
                    children: [
                      Container(
                        child: ListTile(
                          title: Text('자주 묻는 질문'),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: MangoDisabledColor),
                        )),
                      ),
                      Container(
                        child: ListTile(
                          title: Text('공지사항'),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: MangoDisabledColor),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: bottomNaviagtionBar(),
        );
      }
    });
  }

  List<Widget> _buildGridMenu() {
    List<myAccountMenu> _menus = [
      myAccountMenu(
          menuName: '전체 거래 내역',
          iconData: Icons.note_outlined,
          navRef: APPSETTINGS),
      myAccountMenu(
          menuName: '나의 거래 게시글',
          iconData: Icons.account_box_outlined,
          navRef: APPSETTINGS),
      myAccountMenu(
          menuName: 'MY MARKET',
          iconData: Icons.shopping_cart_outlined,
          navRef: APPSETTINGS),
      myAccountMenu(
          menuName: '냉장고 관리',
          iconData: Icons.kitchen_outlined,
          navRef: APPSETTINGS),
      myAccountMenu(
          menuName: '나의 영양 정보 관리',
          iconData: Icons.fact_check_outlined,
          navRef: APPSETTINGS),
      myAccountMenu(
          menuName: '알림 관리',
          iconData: Icons.notifications_none,
          navRef: ALARMSETTINGS),
      myAccountMenu(
          menuName: '앱 설정', iconData: Icons.settings, navRef: APPSETTINGS),
    ];

    return _menus.map((menu) {
      return Container(
        width: 85 * deviceWidth / prototypeWidth,
        height: 80 * deviceHeight / prototypeHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Orange50,
              ),
              child: IconButton(
                icon: Icon(
                  menu.iconData,
                  size: 34 * deviceWidth / prototypeWidth,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => settingAppPage())),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 5.0 * deviceHeight / prototypeHeight),
              child: Text(
                menu.menuName,
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}

class myAccountMenu {
  @required
  String menuName;
  @required
  String navRef;
  @required
  IconData iconData;

  myAccountMenu({this.menuName, this.iconData, this.navRef});
}
