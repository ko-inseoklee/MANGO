import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:plz/colors.dart';
import 'package:plz/view/widget/dialog/dialog.dart';
import 'package:plz/view/widget/setting/settingMenu.dart';

import '../splash.dart';

class settingAlarmPage extends StatefulWidget {
  final String title;

  const settingAlarmPage({Key key, this.title}) : super(key: key);

  @override
  _settingAlarmPageState createState() => _settingAlarmPageState();
}

class _settingAlarmPageState extends State<settingAlarmPage> {
  bool isSwitched = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알람 관리'),
        centerTitle: true,
      ),
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        child: ListView(children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  '알림 설정',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 16.0),
                ),
                padding: EdgeInsets.fromLTRB(
                    15, 20 * deviceWidth / prototypeWidth, 0, 0),
                alignment: Alignment.centerLeft,
              ),
              //TODO: Push Notification 기능 추가
              settingMenu(
                menuName: '푸시 알림 설정',
                onTap: null,
                trailing: Switch(
                  value: isSwitched,
                  activeColor: Orange400,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
                trailingWidth: 60,
              ),
              settingMenu(
                menuName: '알림 주기 설정',
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                trailing: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: Orange400,
                ),
                trailingWidth: 60,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                child: isExpanded
                    ? ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: 60, maxHeight: 300),
                        child: Column(children: [
                          Expanded(
                              child: ListView(
                            children: [setAlarmDuration()],
                          ))
                        ]),
                      )
                    : SizedBox(
                        height: 0.001,
                      ),
              ),

              settingMenu(menuName: '알림음', onTap: () => comingSoon(context))
            ],
          ),
        ]),
      ),
    );
  }

  Widget setAlarmDuration() {
    return Column(children: [
      Container(
        padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
        child: Text(
          '실온 제품',
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: Orange400, fontWeight: FontWeight.w700),
        ),
        alignment: Alignment.centerLeft,
      ),
      settingMenu(menuName: '유통기한 기준', onTap: null),
      settingMenu(menuName: '구매일 기준', onTap: null),
      Container(
        padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
        child: Text(
          '냉장 제품',
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: Orange400, fontWeight: FontWeight.w700),
        ),
        alignment: Alignment.centerLeft,
      ),
      settingMenu(menuName: '유통기한 기준', onTap: null),
      settingMenu(menuName: '구매일 기준', onTap: null),
      Container(
        padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
        child: Text(
          '냉동 제품',
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: Orange400, fontWeight: FontWeight.w700),
        ),
        alignment: Alignment.centerLeft,
      ),
      settingMenu(menuName: '유통기한 기준', onTap: null),
      settingMenu(menuName: '구매일 기준', onTap: null),
    ]);
  }
}
