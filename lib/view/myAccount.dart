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

  List<Widget> _buildGridMenu() {
    List<String> _menuTitle = [
      '전체 거래 내역',
      '나의 거래 게시글',
      'MY MARKET',
      '냉장고 관리',
      '나의 영양 정보 관리',
      '알림 관리',
      '앱 설정'
    ];
    List<IconData> _menuIcon = [
      Icons.note_outlined,
      Icons.account_box_outlined,
      Icons.shopping_cart_outlined,
      Icons.kitchen_outlined,
      Icons.fact_check_outlined,
      Icons.notifications_none,
      Icons.settings
    ];

    List<Widget> _cards = [];

    for (int i = 0; i < _menuTitle.length; i++) {
      Widget _card = Container(
        width: 85 * deviceWidth / prototypeWidth,
        height: 80 * deviceHeight / prototypeHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Orange50,
              ),
              child: IconButton(
                icon: Icon(
                  _menuIcon[i],
                  size: 34 * deviceWidth / prototypeWidth,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () => print('good'),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 5.0 * deviceHeight / prototypeHeight),
              child: Text(
                _menuTitle[i],
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
      );
      _cards.add(_card);
    }

    return _cards;
  }
}
