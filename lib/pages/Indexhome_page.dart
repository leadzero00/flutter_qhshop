import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

//5个主页
import './homepage/home_page.dart';
import './kaoshipage/kaoshi_page.dart';
import './kechengpage/kecheng_page.dart';
import './mediapage/media_page.dart';
import './memberpage/member_page.dart';

import '../provide/indexhome_tabbar.dart';

class MyIndexPage extends StatefulWidget {
  @override
  _MyIndexPageState createState() => _MyIndexPageState();
}

class _MyIndexPageState extends State<MyIndexPage> {
  @override
  void initState() {
    super.initState();
    //_intget();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IndexPageBar(),
    );
  }
}

class IndexPageBar extends StatefulWidget {
  @override
  _IndexPageBarState createState() => _IndexPageBarState();
}

class _IndexPageBarState extends State<IndexPageBar> {
  //底部导航栏
  List<BottomNavigationBarItem> bottomTabs = [
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), title: Text('首頁')),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.video_camera), title: Text('视频课程')),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book), title: Text('在线考试')),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note), title: Text('面授课程')),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled), title: Text('我的'))
      ];

  final List<Widget> tabBoids = [
    MyhomePage(),
    MediaPage(),
    KaoshiPage(),
    KechengPage(),//*-
    MemberPage()
  ]; //小主页面

 // int currentIndex = 0; //切换页面编号
 // var currentPage; //当前显示页面

  //String ceshi = '123';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<IndexHomeTabbarProvide>(
      builder:(context,child,snashot){
        return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex:snashot.currentIndex,
          items: snashot.listbar.map(
            (val){
              return BottomNavigationBarItem(
            icon: Image.network(val['image']), title: Text('${val['title']}'));
            }
          ).toList(),//通过list索引后的方式显示底部导航栏
          onTap: (index) {
            setState(() {
              snashot.setCurrentIndex(index);
              snashot.setCurrentPage(tabBoids[snashot.currentIndex]); //切换页面
            });
          },
        ),
        body: IndexedStack(
          index: snashot.currentIndex,
          children: tabBoids,
        ));
      },
    );
  }
}
