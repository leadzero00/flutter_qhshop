import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './pages/Indexhome_page.dart';
import './pages/login/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';


import './service/service_method.dart';
import 'dart:convert';
import './provide/indexhome_tabbar.dart';
import './provide/cikakecheng.dart';
import './provide/videokecheng.dart';

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
        return MaterialApp(
          title: '仟汇商学院',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,
      ),
      home: StartAd(),
    );
  }
}

class StartAd extends StatefulWidget {
  @override
  _StartAdState createState() => _StartAdState();
}

class _StartAdState extends State<StartAd> with SingleTickerProviderStateMixin {

AnimationController _animationController;
Animation _animation;

//List<Map> listget;

bool Cclick  = false;

@override
  void initState() {
    // TODO: implement initState
    _animationController  =AnimationController(vsync: this,duration: Duration(milliseconds: 3000));
    _animation  = Tween(begin: 0.0,end:1.0).animate(_animationController);
/*动画事件监听器，
    它可以监听到动画的执行状态，
    我们这里只监听动画是否结束，
    如果结束则执行页面跳转动作。 */
    _animation.addStatusListener((status){
      if(status==AnimationStatus.completed){
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context)=>Cclick?MyIndexPage():LoginPage()),//是先进入login界面还是直接进入首页
           (route)=>route==null);
      }
    });
 //播放动画
    _animationController.forward();
     _gettabs();
    super.initState();
  }
   

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }
     //获取底部导航栏的数据
   _gettabs() {
    getrequst('titlepage').then((val) {
      var data = json.decode(val.toString());
      List<Map> tabinfo = (data['data']['tabbar'] as List).cast();
     // print('sfsfsfsdfsfdfsf======>${tabinfo.length}');
     print(tabinfo);
      Provide.value<IndexHomeTabbarProvide>(context).getIndexHomeTabar(tabinfo);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);
    return FadeTransition(
      opacity: _animation,
      child: Image.network(
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1546851657199&di=fdd278c2029f7826790191d59279dbbe&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0112cb554438090000019ae93094f1.jpg%401280w_1l_2o_100sh.jpg',
        scale: 2.0,
        fit: BoxFit.cover,
        ),
      
    );
  }
}