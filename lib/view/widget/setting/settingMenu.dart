import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plz/colors.dart';
import 'package:plz/view/splash.dart';

class settingMenu extends StatefulWidget {
  final String menuName;
  final VoidCallback onTap;
  final Widget trailing;

  const settingMenu(
      {Key key, @required this.menuName, @required this.onTap, this.trailing})
      : super(key: key);

  @override
  _settingMenuState createState() => _settingMenuState();
}

class _settingMenuState extends State<settingMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
          height: 60 * deviceHeight / prototypeHeight,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: MangoDisabledColor),
            ),
            color: Colors.white,
          ),
          child: ListTile(
            title: Text(
              widget.menuName,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.left,
            ),
            onTap: widget.onTap,
            trailing: widget.trailing,
          ),
        ));
  }
}
