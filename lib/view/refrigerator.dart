import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class refrigeratorPage extends StatefulWidget {
  final String title;

  const refrigeratorPage({Key key, this.title}) : super(key: key);

  @override
  _refrigeratorPageState createState() => _refrigeratorPageState();
}

class _refrigeratorPageState extends State<refrigeratorPage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Text('냉장고 페이지'),
      ),
    );
  }
}
