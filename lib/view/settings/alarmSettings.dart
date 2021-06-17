import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:plz/colors.dart';
import 'package:plz/model/user.dart';
import 'package:plz/view/widget/dialog/dialog.dart';
import 'package:plz/view/widget/setting/settingMenu.dart';
import 'package:plz/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DocumentSnapshot _user;

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('알람 관리'),
        centerTitle: true,
      ),
      backgroundColor: MangoWhite,
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
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                      color: Orange400),
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
                            children: [setAlarm()],
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

  // Picker picker(BuildContext context) {
  //   Picker picker = Picker(
  //       textAlign: TextAlign.center,
  //       adapter: PickerDataAdapter<int>(pickerdata: dateData()),
  //       changeToFirst: false,
  //       onConfirm: (Picker picker, List value) {
  //         setState(() {
  //           int val = picker.getSelectedValues()[0];
  //           _refrigerationAlarm = val;
  //
  //           print(_refrigerationAlarm);
  //         });
  //       });
  //   return picker;
  // }
  //
  // void showPicker(BuildContext context, Picker picker) {
  //   picker.showModal(this.context);
  // }

  List<int> dateData() {
    List<int> result = [];
    for (int i = 1; i <= 60; i++) {
      result.add(i);
    }

    return result;
  }
}

class setAlarm extends StatefulWidget {
  @override
  setAlarmState createState() => setAlarmState();
}

class setAlarmState extends State<setAlarm> {
  int _refrigerationAlarm;
  bool _isRefShelf;
  int _frozenAlarm;
  bool _isFroShelf;
  int _roomTempAlarm;
  bool _isRTShelf;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      _isRefShelf = userViewModel.user.isRefShelf;
      _isFroShelf = userViewModel.user.isFroShelf;
      _isRTShelf = userViewModel.user.isRTShelf;
      _refrigerationAlarm = userViewModel.user.refrigerationAlarm;
      _frozenAlarm = userViewModel.user.frozenAlarm;
      _roomTempAlarm = userViewModel.user.roomTempAlarm;

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
        settingMenu(
          menuName: '유통기한 기준',
          onTap: null,
          trailing: FlatButton(
              onPressed: () {
                showMaterialNumberPicker(
                    context: context,
                    minNumber: 1,
                    maxNumber: 60,
                    selectedNumber: userViewModel.user.roomTempAlarm,
                    onChanged: (value) {
                      setState(() {
                        userViewModel.rTAlarm = value;
                      });
                    });
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: _isRTShelf
                        ? Text(
                            _roomTempAlarm.toString() + "일 전",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : Text('-'),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: _isRTShelf ? MangoBlack : MangoBehindColor,
                    size: 18.0,
                  )
                ],
              )),
          trailingWidth: 100,
          isActive: _isRTShelf,
        ),
        settingMenu(
          menuName: '구매일 기준',
          onTap: null,
          trailing: FlatButton(
              onPressed: () {
                showMaterialNumberPicker(
                    context: context,
                    minNumber: 1,
                    maxNumber: 60,
                    selectedNumber: userViewModel.user.roomTempAlarm,
                    onChanged: (value) {
                      setState(() {
                        userViewModel.refAlarm = value;
                      });
                    });
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: !_isRTShelf
                        ? Text(
                            _roomTempAlarm.toString() + "일 후",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : Text('-'),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: !_isRTShelf ? MangoBlack : MangoBehindColor,
                    size: 18.0,
                  )
                ],
              )),
          trailingWidth: 100,
          isActive: !_isRTShelf,
        ),
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
        settingMenu(
          menuName: '유통기한 기준',
          onTap: null,
          isActive: _isRefShelf,
          trailing: FlatButton(
              onPressed: () {
                showMaterialNumberPicker(
                    context: context,
                    minNumber: 1,
                    maxNumber: 60,
                    selectedNumber: userViewModel.user.refrigerationAlarm,
                    onChanged: (value) {
                      setState(() {
                        userViewModel.refAlarm = value;
                      });
                    });
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: _isRefShelf
                        ? Text(
                            _refrigerationAlarm.toString() + "일 전",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : Text('-'),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: _isRefShelf ? MangoBlack : MangoBehindColor,
                    size: 18.0,
                  )
                ],
              )),
          trailingWidth: 100,
        ),
        settingMenu(
          menuName: '구매일 기준',
          onTap: null,
          isActive: !_isRefShelf,
          trailing: FlatButton(
              onPressed: () {
                showMaterialNumberPicker(
                    context: context,
                    minNumber: 1,
                    maxNumber: 60,
                    selectedNumber: userViewModel.user.refrigerationAlarm,
                    onChanged: (value) {
                      setState(() {
                        userViewModel.refAlarm = value;
                      });
                    });
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: !_isRefShelf
                        ? Text(
                            _refrigerationAlarm.toString() + "일 후",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : Text('-'),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: !_isRefShelf ? MangoBlack : MangoBehindColor,
                    size: 18.0,
                  )
                ],
              )),
          trailingWidth: 100,
        ),
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
        settingMenu(
          menuName: '유통기한 기준',
          onTap: null,
          isActive: _isFroShelf,
          trailing: FlatButton(
              onPressed: () {
                showMaterialNumberPicker(
                    context: context,
                    minNumber: 1,
                    maxNumber: 60,
                    selectedNumber: userViewModel.user.refrigerationAlarm,
                    onChanged: (value) {
                      setState(() {
                        userViewModel.refAlarm = value;
                      });
                    });
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: _isFroShelf
                        ? Text(
                            _frozenAlarm.toString() + "일 전",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : Text('-'),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: _isFroShelf ? MangoBlack : MangoBehindColor,
                    size: 18.0,
                  )
                ],
              )),
          trailingWidth: 100,
        ),
        settingMenu(
          menuName: '구매일 기준',
          onTap: null,
          isActive: !_isFroShelf,
          trailing: FlatButton(
              onPressed: () {
                showMaterialNumberPicker(
                    context: context,
                    minNumber: 1,
                    maxNumber: 60,
                    selectedNumber: userViewModel.user.refrigerationAlarm,
                    onChanged: (value) {
                      setState(() {
                        userViewModel.refAlarm = value;
                      });
                    });
              },
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    child: !_isFroShelf
                        ? Text(
                            _frozenAlarm.toString() + "일 후",
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        : Text('-'),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: !_isFroShelf ? MangoBlack : MangoBehindColor,
                    size: 18.0,
                  )
                ],
              )),
          trailingWidth: 100,
        ),
      ]);
    });
  }
}
