import 'package:flutter/material.dart';
import 'package:plz/view/home.dart';
import 'package:plz/view/splash.dart';

class settingAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('앱 설정'),
          centerTitle: true,
        ),
        body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 355 * deviceWidth / prototypeWidth,
              height: 165 * deviceHeight / prototypeHeight,
              // padding: EdgeInsets.all(10 * deviceWidth / prototypeWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ListTile(
                        onTap: () => print('good'),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 355 * deviceWidth / prototypeWidth,
              height: 240 * deviceHeight / prototypeHeight,
              // padding: EdgeInsets.all(10 * deviceWidth / prototypeWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('기타')],
              ),
            ),
          ]),
        ));
  }
}
