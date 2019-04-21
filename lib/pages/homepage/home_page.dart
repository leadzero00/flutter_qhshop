import 'package:flutter/material.dart';
import 'appbar_page.dart';
import 'homepages.dart';

class MyhomePage extends StatefulWidget {
  @override
  _MyhomePageState createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            alignment: Alignment.center,
            child: Text('企联商学院'),
          ),
          actions: <Widget>[
            MyAppBar()
          ],
        ),
        body: Homepages()
      ),
    );
  }
}

