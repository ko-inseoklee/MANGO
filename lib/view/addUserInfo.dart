import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plz/colors.dart';
import 'package:plz/model/user.dart';
import 'package:plz/routes.dart';
import 'package:plz/view/splash.dart';
import 'package:plz/viewModel/authentication.dart';
import 'package:plz/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class addUserInfoPage extends StatefulWidget {
  @override
  _addUserInfoPageState createState() => _addUserInfoPageState();
}

class _addUserInfoPageState extends State<addUserInfoPage> {
  List<String> _pageTitle = ['개인정보 설정', '알림 주기 설정'];

  bool _isFirstPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MangoWhite,
        appBar: AppBar(
          title: Text(
            _isFirstPage ? _pageTitle[0] : _pageTitle[1],
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: MangoWhite,
        ),
        body: _isFirstPage
            ? setPersonalDataPage(context)
            : setAlarmPage(context));
  }

  //Data for newbie user

  Widget setPersonalDataPage(BuildContext context) {
    var _user = Provider.of<User>(context);
    var _contentWidth = 350.0;

    final _nameController = TextEditingController();

    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20 * (deviceWidth / prototypeWidth)),
            width: _contentWidth * (deviceWidth / prototypeWidth),
            child: Text('망고에서 사용하실 이름을 입력해주세요.'),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 14 * (deviceWidth / prototypeWidth),
                0, 33 * (deviceWidth / prototypeWidth)),
            width: _contentWidth * (deviceWidth / prototypeWidth),
            child: TextField(
              maxLength: 12,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-z]'))
              ],
              controller: _nameController,
              decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).errorColor, width: 1.0),
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor, width: 1.0),
                  ),
                  // border: OutlineInputBorder(),
                  hintText: _user.userName,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: MangoBlack.withOpacity(0.5))),
            ),
          ),
          ButtonTheme(
              // 46.0: Prototype Height of The button / 5.0:BorderRatio
              minWidth: _contentWidth * (deviceWidth / prototypeWidth),
              height: 46.0 * (deviceWidth / prototypeWidth),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () async {
                  setState(() {
                    print(_nameController.text);

                    print(_user.userName);

                    Navigator.popAndPushNamed(context, HOME);
                    // 나중에 사용할 것. 두번째 페이지 변경
                    // _isFirstPage = false;
                  });
                },
                child:
                    //TODO: It will be change '인증' after adding phone number authentication.
                    Text(
                  '다음',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              )),
        ],
      ),
    );
  }

  Widget setAlarmPage(BuildContext context) {
    return Center(
      child: Text('next set alarm page!'),
    );
  }
}
