import 'package:flutter/material.dart';

class marketPage extends StatelessWidget {
  final String title;

  const marketPage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Text('market page!'),
      ),
    );
  }
}
