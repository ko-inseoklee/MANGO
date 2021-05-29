import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plz/colors.dart';
import 'package:plz/model/user.dart';
import 'package:plz/view/splash.dart';
import 'package:provider/provider.dart';

class myPage extends StatefulWidget {
  @override
  _myPageState createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot _documentSnapshot = Provider.of<DocumentSnapshot>(context);
    User _user = new User.fromSnapshot(_documentSnapshot);

    print(_user.profileImageReference);

    return Scaffold(
      appBar: AppBar(
        title: Text('마이 페이지'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 110 * deviceHeight / prototypeHeight,
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
                          image: _user.profileImageReference == '-1'
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
                      _user.userName,
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
              height: 220 * deviceHeight / prototypeHeight,
              child: Center(
                child: Text('my page!'),
              ),
            ),
            Container(
              height: 7 * deviceHeight / prototypeHeight,
              color: MangoBehindColor,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(7 * deviceWidth / prototypeWidth,
                    0, 7 * deviceWidth / prototypeWidth, 0),
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
    );
  }
}
