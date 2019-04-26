import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provide/provide.dart';


import './provide/indexhome_tabbar.dart';
import './provide/cikakecheng.dart';
import './provide/videokecheng.dart';

//路由注入
import './routers/application.dart';
import './routers/router.dart';
import 'package:fluro/fluro.dart';

import './ad_page.dart';

void main() {
  var tabbarlist = IndexHomeTabbarProvide();
  var cikekecheng = CiKaKechengProvide();
  var videokecheng = VideoKechengProvide();
  var providers = Providers();
  providers..provide(Provider<IndexHomeTabbarProvide>.value(tabbarlist));
  providers..provide(Provider<CiKaKechengProvide>.value(cikekecheng));
  providers..provide(Provider<VideoKechengProvide>.value(videokecheng));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var greenAccent = Colors.greenAccent;
    //路由注入
    final router = Router();
    Routes.configureRoutes(router);
    Appliaction.router = router;
    //路由注入结束
    return MaterialApp(
      title: '仟汇商学院',
      debugShowCheckedModeBanner: false,
      //----------------路由主要代码start
      onGenerateRoute: Appliaction.router.generator,
      //----------------路由主要代码end
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: StartAd(),
    );
  }
}

