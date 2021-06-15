import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plz/colors.dart';
import 'package:plz/model/user.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/settings/alarmSettings.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/view/settings/appSetting/appSettings.dart';
import 'package:plz/view/widget/dialog/dialog.dart';
import 'package:plz/view/widget/setting/settingMenu.dart';
import 'package:provider/provider.dart';

class myPage extends StatefulWidget {
  final String title;

  const myPage({Key key, this.title}) : super(key: key);

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
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
          ),
          backgroundColor: MangoWhite,
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
                      settingMenu(
                        menuName: "자주 묻는 질문",
                        onTap: () {
                          comingSoon(context);
                        },
                      ),
                      settingMenu(
                        menuName: "공지사항",
                        onTap: () {
                          comingSoon(context);
                        },
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
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Orange50,
              ),
              child: IconButton(
                alignment: Alignment.center,
                icon: Icon(
                  menu.iconData,
                  size: 28 * deviceWidth / prototypeWidth,
                  color: Theme.of(context).accentColor,
                ),
                //TODO: condition should be deleted after make certain contents.
                onPressed: () => menu.menuName == '앱 설정'
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => settingAppPage(
                              title: "앱 설정",
                            )))
                    : menu.menuName == '알림 관리'
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => settingAlarmPage(
                                  title: "알림 관리",
                                )))
                        : comingSoon(context),
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
