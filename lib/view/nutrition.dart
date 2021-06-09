import 'package:flutter/material.dart';

class nutritionPage extends StatelessWidget {
  final String title;

  const nutritionPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: Center(
          child: Text('영양 페이지!'),
        ));
  }
}
