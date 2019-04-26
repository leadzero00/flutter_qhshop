import 'package:flutter/material.dart';
import './sign_in_page.dart';
import './sign_up_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  PageController _pageController;
  PageView _pageView;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    //_initFluwx();//微信初始化
    _pageController = new PageController();
    _pageView = new PageView(
      controller: _pageController,
      children: <Widget>[
        new SignInPage(),
        new SignUpPage(),
      ],
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
    );
  }
   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// SafeArea，让内容显示在安全的可见区域
        // SafeArea，可以避免一些屏幕有刘海或者凹槽的问
        body: SafeArea(
      child: SingleChildScrollView(
          // 用SingleChildScrollView+Column，避免弹出键盘的时候，出现overFlow现象
          child: Container(
              //这里要手动设置container的高度和宽度，不然显示不了利用MediaQuery可以获取到跟屏幕信息有关的数据
              height: ScreenUtil().setHeight(1330),
              width: ScreenUtil().setWidth(750),
              //设置渐变的背景
              decoration: new BoxDecoration(),
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  //可以用SizeBox这种写法代替Padding：在Row或者Column中单独设置一个方向的间距的时候
                  // new Padding(padding: EdgeInsets.only(top: 75)),
                  //顶部图片
                  new Image(
                      width: ScreenUtil().setWidth(250),//250
                      height:ScreenUtil().setHeight(300),//191,
                      image:
                          new AssetImage("assets/images/logo/login_logo.png")),
                  new SizedBox(
                    height: ScreenUtil().setHeight(20),
                   // width: ScreenUtil().setWidth(100),
                  ),
                  //中间的Indicator指示器
                  new Container(
                    width: ScreenUtil().setWidth(400),
                    height: ScreenUtil().setHeight(70),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Color(0x552B2B2B),
                    ),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                            child: new Container(
                          // TODO:暂时不会用Paint去自定义indicator，所以暂时只能这样实现了
                          decoration: _currentPage == 0
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white,
                                )
                              : null,
                          child: new Center(
                            child: new FlatButton(
                              onPressed: () {
                             //   print('hahahahahahahahahahahhah');
                                _pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              },
                              child: new Text(
                                "登陆",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                        Expanded(
                            child: new Container(
                          decoration: _currentPage == 1
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white,
                                )
                              : null,
                          child: new Center(
                            child: new FlatButton(
                              onPressed: () {
                                _pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              },
                              child: new Text(
                                "新账号",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
//                      new SignInPage(),
//                      new SignUpPage(),
                  new Expanded(child: _pageView),
                ],
              ))),
    ));
  }
}
