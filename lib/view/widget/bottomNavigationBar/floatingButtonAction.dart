import 'package:flutter/material.dart';
import 'package:plz/colors.dart';

class floatingButtonAction extends StatefulWidget {
  @override
  _floatingButtonActionState createState() => _floatingButtonActionState();
}

class _floatingButtonActionState extends State<floatingButtonAction> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '냉장고 품목 등록',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w700),
          ),
          ButtonTheme(
            minWidth: 50,
            // colorScheme: Theme.of(context).colorScheme,
            buttonColor: MangoBehindColor,
            child: RaisedButton(
              child: Text('직접입력', style: Theme.of(context).textTheme.subtitle2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      )),
      content: Container(
        height: 200,
        child: Column(
          children: [
            Text(
              '영수증 또는 실제 모습을 촬영해주시면',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              '자동으로 냉장고에 등록해 드립니다.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonTheme(
                  // colorScheme: Theme.of(context).colorScheme,
                  buttonColor: MangoBehindColor,
                  child: RaisedButton(
                    child: Text('영수증', style: TextStyle(color: MangoBlack)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                ButtonTheme(
                  // colorScheme: Theme.of(context).colorScheme,
                  buttonColor: MangoBehindColor,
                  child: RaisedButton(
                    child: Text('사물인식', style: TextStyle(color: MangoBlack)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                ButtonTheme(
                  // colorScheme: Theme.of(context).colorScheme,
                  buttonColor: MangoBehindColor,
                  // minWidth: 200,
                  child: RaisedButton(
                    child: Text('촬영', style: TextStyle(color: MangoBlack)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                ButtonTheme(
                  // colorScheme: Theme.of(context).colorScheme,
                  buttonColor: MangoBehindColor,
                  // minWidth: 200,
                  child: RaisedButton(
                    child: Text('앨범에서 선택', style: TextStyle(color: MangoBlack)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
      titlePadding: EdgeInsets.fromLTRB(0, 15.0, 0, 20.0),
      actionsPadding: EdgeInsets.fromLTRB(20, 33, 20, 45),
      actions: [
        ButtonTheme(
          // colorScheme: Theme.of(context).colorScheme,
          buttonColor: MangoBehindColor,
          // minWidth: 200,
          child: RaisedButton(
            child: Text('취소', style: TextStyle(color: MangoBlack)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
