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
        title: Text('알람 설정'),
        centerTitle: true,
      ),
      body: Container(
        width: deviceWidth,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  child: Text(
                    '알림 설정',
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  padding: EdgeInsets.fromLTRB(
                      10, 20 * deviceWidth / prototypeWidth, 0, 0),
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
                    )),
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
                ),
                settingMenu(menuName: '알림음', onTap: () => comingSoon(context))
              ],
            )
          ],
        ),
      ),
    );
  }
}
