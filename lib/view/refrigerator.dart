import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class refrigeratorPage extends StatefulWidget {
  final CounterStorage storage;

  const refrigeratorPage({Key key, this.storage}) : super(key: key);
  @override
  _refrigeratorPageState createState() => _refrigeratorPageState();
}

class _refrigeratorPageState extends State<refrigeratorPage> {
  int _counter = 0;

  // var file;
  // var bytes;
  // var excel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.storage.readCounter().then((int value) {
    //   setState(() {
    //     _counter = value;
    //   });
    // });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    // for (var table in excel.table.keys) {
    //   print(table);
    // }

    return Scaffold(
      body: Center(child: Text('냉장고 페이지!')),
    );
  }
}

class CounterStorage {
  int test;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}
