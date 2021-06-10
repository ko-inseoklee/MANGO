import 'package:flutter/material.dart';
import 'package:plz/colors.dart';

class mangoDialog extends StatefulWidget {
  final String dialogTitle;
  final String contentText;

  final VoidCallback onTapOK;

  const mangoDialog(
      {Key key,
      @required this.dialogTitle,
      @required this.contentText,
      @required this.onTapOK});

  @override
  _mangoDialogState createState() => _mangoDialogState();
}

class _mangoDialogState extends State<mangoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.dialogTitle),
      content: Text(widget.contentText),
      actions: [
        FlatButton(
            child: Text('확인', style: TextStyle(color: Orange400)),
            onPressed: widget.onTapOK),
        FlatButton(
          child: Text('취소', style: TextStyle(color: MangoDisabledColor)),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
