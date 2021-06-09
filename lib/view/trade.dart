import 'package:flutter/material.dart';

class tradePage extends StatelessWidget {
  final String title;

  const tradePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Center(
          child: Text('trade page!'),
        ));
  }
}
