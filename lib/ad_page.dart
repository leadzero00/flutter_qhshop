import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './pages/Indexhome_page.dart';
import './pages/login/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './service/service_method.dart';
import 'dart:convert';
//数据存储
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provide/provide.dart';

import './provide/indexhome_tabbar.dart';

class StartAd extends StatefulWidget {
  @override
  _StartAdState createState() => _StartAdState();
}

class _StartAdState extends State<StartAd> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

//List<Map> listget;

  var Cclick ;
  
  _StartAdState(){
    print("启动时候构造方法测试!!!!");
    getCKey();
  }

   getCKey() async{
   SharedPreferences _sharedperences = await SharedPreferences.getInstance();
    /*
    构建sp类并使用
    main() async {
    // 构建sp类
   SharedPreferences sp = await SharedPreferences.getInstance();
  // 存储
  sp.setString("name", "lee");
  sp.setInt("age", 24);
  // 读取
  sp.getString("name");// "lee"
  sp.getInt("age");// 24
  sp.get("name");// "lee"
  //清除
  sp.clear()
  sp.remove("name")
} 
    */
    try {
        Cclick = _sharedperences.getInt('loginkey');
         print('Cclick的获取的值为:=====>$Cclick');
        if(Cclick==null)
        {
          Cclick = 0;
        }
    } catch (e) {
      print(e.toString());
    }
  
    print('Cclick的获取的值为:=====>$Cclick');
   }
  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
   
/*动画事件监听器，
    它可以监听到动画的执行状态，
    我们这里只监听动画是否结束，
    如果结束则执行页面跳转动作。 */
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Cclick < 1
                    ? LoginPage(): MyIndexPage()
                    ), //是先进入login界面还是直接进入首页
            (route) => route == null);
      }
    });
    //播放动画
    _animationController.forward();
    _gettabs();
    super.initState();
  }

  @override
  void dispose() {
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
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
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
