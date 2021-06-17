import 'package:flutter/material.dart';
import 'package:plz/viewModel/authentication.dart';
import 'package:provider/provider.dart';

class marketPage extends StatelessWidget {
  final String title;

  const marketPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _auth = Provider.of<Authentication>(context);
    //
    // _auth.signOut();

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
