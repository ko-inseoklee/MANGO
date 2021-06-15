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
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: 250 * (deviceHeight / prototypeHeight),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '사용자 설정',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    padding: EdgeInsets.fromLTRB(
                        10, 20 * deviceWidth / prototypeWidth, 0, 0),
                  ),
                  Expanded(
                      // padding: EdgeInsets.all(10 * deviceWidth / prototypeWidth),
                      child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                    ],
                  )),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '기타',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  padding: EdgeInsets.fromLTRB(
                      10, 20 * deviceWidth / prototypeWidth, 0, 0),
                ),
              ],
            ),
            Expanded(
                // padding: EdgeInsets.all(10 * deviceWidth / prototypeWidth),
                child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    print("삭제 시작..");
                                    print(
                                        'userdata == ${_user.data()['refrigerator_id']}');
                                    await refrigeratorController()
                                        .deleteRefrigerator(
                                            refID: _user
                                                .data()['refrigerator_id']);
                                    await UserViewModel()
                                        .deleteUser(uid: _user.data()['uid']);

                                    await _auth.signOut();
                                    print("삭제 완료 및 로그아웃");
                                    Navigator.popAndPushNamed(context, LANDING);
                                  });
                            });
                      },
                    )
                  ],
                ),
              ],
            )),
          ]),
        ));
  }

  List<ListTile> _buildAppSettingTile() {}
}
