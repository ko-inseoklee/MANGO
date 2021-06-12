import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plz/colors.dart';
import 'package:plz/controller/authentication.dart';
import 'package:plz/controller/refrigeratorController.dart';
import 'package:plz/controller/userController.dart';
import 'package:plz/model/user.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/view/widget/dialog/dialog.dart';
import 'package:plz/view/widget/setting/settingMenu.dart';
import 'package:provider/provider.dart';

import '../../../routes.dart';

class settingAppPage extends StatelessWidget {
  final String title;

  settingAppPage({Key key, this.title}) : super(key: key);

  Authentication _auth;
  DocumentSnapshot _user;

  // Future<void> signOut(Authentication auth) async {
  //   await auth.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<Authentication>(context);
    _user = Provider.of<DocumentSnapshot>(context);

    return Scaffold(
        backgroundColor: MangoWhite,
        appBar: AppBar(
          title: Text('앱 설정'),
          centerTitle: true,
        ),
        body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 355 * deviceWidth / prototypeWidth,
              height: 230 * deviceHeight / prototypeHeight,
              // padding: EdgeInsets.all(10 * deviceWidth / prototypeWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '사용자 설정',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    padding:
                        EdgeInsets.only(top: 20 * deviceWidth / prototypeWidth),
                  ),
                  settingMenu(
                    menuName: "계정/정보 관리",
                    onTap: () {
                      comingSoon(context);
                    },
                  ),
                  settingMenu(
                    menuName: "차단 사용자 관리",
                    onTap: () {
                      comingSoon(context);
                    },
                  ),
                  settingMenu(
                    menuName: "기타 설정",
                    onTap: () {
                      comingSoon(context);
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: 355 * deviceWidth / prototypeWidth,
              height: 350 * deviceHeight / prototypeHeight,
              // padding: EdgeInsets.all(10 * deviceWidth / prototypeWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '기타',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    padding:
                        EdgeInsets.only(top: 20 * deviceWidth / prototypeWidth),
                  ),
                  settingMenu(
                    menuName: "언어 설정",
                    onTap: () {
                      comingSoon(context);
                    },
                  ),
                  settingMenu(
                    menuName: "캐시 데이터 삭제",
                    onTap: () {
                      comingSoon(context);
                    },
                  ),
                  settingMenu(
                    menuName: "버전 정보",
                    onTap: () {
                      comingSoon(context);
                    },
                  ),
                  settingMenu(
                    menuName: "로그아웃",
                    onTap: () async {
                      print("s");
                      _auth.signOut();
                      Navigator.popAndPushNamed(context, LANDING);
                    },
                  ),
                  settingMenu(
                    menuName: "회원탈퇴",
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return mangoDialog(
                                dialogTitle: "회원탈퇴",
                                contentText: "정말 탈퇴하시겠습니까?",
                                hasOK: true,
                                onTapOK: () async {
                                  await refrigeratorController()
                                      .deleteRefrigerator(
                                          refID:
                                              _user.data()['refrigerator_id']);
                                  await UserViewModel()
                                      .deleteUser(uid: _user.data()['uid']);

                                  await _auth.signOut();
                                  Navigator.popAndPushNamed(context, LANDING);
                                });
                          });
                    },
                  )
                ],
              ),
            ),
          ]),
        ));
  }

  List<ListTile> _buildAppSettingTile() {}
}
