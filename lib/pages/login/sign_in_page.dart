import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/theme.dart' as theme;
import 'package:fluwx/fluwx.dart' as fluwx;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../Indexhome_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*
 *注册界面
 */
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  /**
   * 利用FocusNode和FocusScopeNode来控制焦点
   * 可以通过FocusNode.of(context)来获取widget树中默认的FocusScopeNode
   */
  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusScopeNode focusScopeNode = new FocusScopeNode();

  GlobalKey<FormState> _SignInFormKey = new GlobalKey();

  bool isShowPassWord = false;
 
  String _result = '无';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initFluwx() ;//微信初始化
    fluwx.responseFromAuth.listen((data){
      setState(() {
       _result = "${data.errCode}"; 
      });
    });
  }

  @override
  void dispose() { 
    super.dispose();
    _result = null;
  }

 _initFluwx() async{
     await fluwx.register(
       appId: 'wx2050d968bab10dd0',
       doOnAndroid: true,
       doOnIOS: true,
       enableMTA: false
     );
     var result = await fluwx.isWeChatInstalled();
     if (result) {
       return true;
     } else {
       return false;
     }
   }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 23),
      child: new Stack(
        alignment: Alignment.center,
//        /**
//         * 注意这里要设置溢出如何处理，设置为visible的话，可以看到孩子，
//         * 设置为clip的话，若溢出会进行裁剪
//         */
//        overflow: Overflow.visible,
        children: <Widget>[
          new Column(
            children: <Widget>[
              //创建表单
              buildSignInTextForm(),

              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: new Text(
                  "忘记密码?::::$_result",
                  style: new TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
              /*
               * Or所在的一行
               */
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: new Row(
//                          mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: ScreenUtil().setHeight(1),
                      width: ScreenUtil().setWidth(100),// 100,
                      decoration: BoxDecoration(
                          gradient: new LinearGradient(
                            colors: [
                        Colors.white10,
                        Colors.white,
                      ])),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: new Text(
                        "或者使用以下方式登陆",
                        style: new TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    new Container(
                     height: ScreenUtil().setHeight(1),
                      width: ScreenUtil().setWidth(100),// 100,
                      decoration: BoxDecoration(
                          gradient: new LinearGradient(colors: [
                        Colors.white,
                        Colors.white10,
                      ])),
                    ),
                  ],
                ),
              ),
              /*
               * 显示第三方登录的按钮
               */
              new SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //微信支付
                   new Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new IconButton(
                        icon: Icon(
                          FontAwesomeIcons.weixin,
                          color: Color(0xFF0084ff),
                        ),
                        onPressed: (){
                          fluwx.sendAuth(
                             scope: "snsapi_userinfo", 
                             state: "wechat_sdk_demo_test"
                          ).then((val){
                            print("发送认证后的数据:::::::$val");
                            setState(() {
                              int i = 0;
                              if(i<=1)
                              {
                                 _result = _result+"<=>"+val.toString();
                                 i++;
                              }
                              if(i>1)
                              {
                                i = 0;
                              }
                            });                       
                          });
                        }),
                  ),
                  //支付宝
                   new Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new IconButton(
                        icon: Icon(
                          FontAwesomeIcons.alipay,
                          color: Color(0xFF0084ff),
                        ),
                        onPressed: null),
                  ),
                  //facebook
                  new Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new IconButton(
                        icon: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Color(0xFF0084ff),
                        ),
                        onPressed: null),
                  ),
                  // new SizedBox(
                  //   width: ScreenUtil().setWidth(40),
                  // ),
                  new Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new IconButton(
                        icon: Icon(
                          FontAwesomeIcons.google,
                          color: Color(0xFF0084ff),
                        ),
                        onPressed: null),
                  ),
                ],
              )
            ],
          ),
          new Positioned(
            child: buildSignInButton(),
            top: 170,
          )
        ],
      ),
    );
  }

  /**
   * 点击控制密码是否显示
   */
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  /**
   * 创建登录界面的TextForm
   */
  Widget buildSignInTextForm() {
    return new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      height: ScreenUtil().setHeight(400),
      width: ScreenUtil().setWidth(500),// 190
      /*
       * Flutter提供了一个Form widget，它可以对输入框进行分组，
       * 然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
       */
      child:  Form(
        key: _SignInFormKey,
        //开启自动检验输入内容，最好还是自己手动检验，不然每次修改子孩子的TextFormField的时候，其他TextFormField也会被检验，感觉不是很好
//        autovalidate: true,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: new TextFormField(
                  //关联焦点
                  focusNode: emailFocusNode,
                  onEditingComplete: () {
                    if (focusScopeNode == null) {
                      focusScopeNode = FocusScope.of(context);
                    }
                    focusScopeNode.requestFocus(passwordFocusNode);
                  },

                  decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: "账号/邮件地址",
                      border: InputBorder.none),
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  //验证
                  validator: (value) {
                    if (value.isEmpty) {
                      return "邮件地址为空!";
                    }
                  },
                  onSaved: (value) {
                    print("账号数据=======> $value");
                  },
                ),
              ),
            ),
            new Container(
             height: ScreenUtil().setHeight(1),
                      width: ScreenUtil().setWidth(250),// 100,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: new TextFormField(
                  focusNode: passwordFocusNode,
                  decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "密码",
                      border: InputBorder.none,
                      suffixIcon: new IconButton(
                          icon: new Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          onPressed: showPassWord)),
                  //输入密码，需要用*****显示
                  obscureText: !isShowPassWord,
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return "密码长度必须大于或等于6位!";
                    }
                  },
                  onSaved: (value) {
                    print('获取的东西啊啊啊========> $value');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * 创建登录界面的按钮
   */
  Widget buildSignInButton() {
    return new GestureDetector(
      child: new Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: theme.Theme.primaryGradient,
        ),
        child: new Text(
          "LOGIN",
          style: new TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        /*利用key来获取widget的状态FormState
              可以用过FormState对Form的子孙FromField进行统一的操作
           */
        if (_SignInFormKey.currentState.validate()) {
          //如果输入都检验通过，则进行登录操作
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text("执行登录操作")));
          //调用所有自孩子的save回调，保存表单内容
          _SignInFormKey.currentState.save();
          const data ={
            "username":"18608746661",
            "password":"diaoling",
            "mode":"veVC"
            };
            postlogin('http://www.iqhyun.com/addons/ck_zhxt/inc/mobile/login.incc.php',formdata:data).then((val){
            print(val.toString());
             var data1  = json.decode(val.toString());
             var sess = data1['data'].toString();
             //print(sess);
            if(sess=="seccuse"){
             // print('222222');
             return  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=>MyIndexPage()), (route)=> route==null);//首页跳转
            }else{
            return Fluttertoast.showToast(
              msg: val.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              fontSize: 16.0);
            }
            
          });
          
        }
//          debugDumpApp();
      },
    );
  }

  Future postlogin(var url,{formdata}) async{
    try{
     Response response;
     Dio dio = Dio();
     dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
     response = await dio.post(url,data:formdata);
     return response.data;
    }catch(e){
      print('ERROR:======>${e}');
    }
  }
}
