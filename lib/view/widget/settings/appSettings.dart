import 'package:flutter/material.dart';
import 'package:plz/controller/authentication.dart';
import 'package:plz/view/splash.dart';
import 'package:provider/provider.dart';

class settingAppPage extends StatelessWidget {
  final String title;

  const settingAppPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _auth = Provider.of<Authentication>(context);

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
                children: [
                  Text('기타'),
                  ListTile(
                    title: Text("로그아웃"),
                    onTap: () async => _auth.signOut(),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
