import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:plz/view/guide.dart';
import 'package:plz/view/landing.dart';

class splashPage extends StatefulWidget {
  @override
  _splashPageState createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {
  bool _isFirstRun = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isFirstRun(),
        builder: (BuildContext context, AsyncSnapshot snapshots) {
          if (snapshots.hasData == false) {
            return null;
          } else if (snapshots.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshots.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return _isFirstRun ? guidePage() : landingPage();
          }
        });
  }

  Future<bool> isFirstRun() async {
    _isFirstRun = await IsFirstRun.isFirstRun();
    return _isFirstRun;
  }
}
