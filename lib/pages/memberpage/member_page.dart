import 'package:flutter/material.dart';
import './membertitle_page.dart';
import './member_navigator.dart';
import './drawer_page.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('个人中心'),
      // ),
      drawer: LeftDrawerPage(),
      body: Container(
  //    width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.zero,
      child:Column(
        children: <Widget>[
            MemberTitle(),
           GridViewNavigatorList()
        ],
      )
      

    ),
    );
  }
}
