import 'package:flutter/material.dart';

class settingAlarmPage extends StatelessWidget {
  final String title;

  const settingAlarmPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알람 설정'),
        centerTitle: true,
      ),
    );
  }
}
