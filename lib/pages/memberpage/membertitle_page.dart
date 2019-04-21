import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberTitle extends StatefulWidget {
  @override
  _MemberTitleState createState() => _MemberTitleState();
}

class _MemberTitleState extends State<MemberTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
       //height: ScreenUtil().setHeight(360),
      color: Colors.lightBlue,
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[
          _setting(),
          _info(),
          _bottominfo()
        ],
    ),
    );
  }
  
  Widget _setting(){
    return Container( 
      height: ScreenUtil().setHeight(35),
      padding: EdgeInsets.only(right: 10.0,bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            alignment: Alignment.centerRight,
            onPressed: (){
              
            },
          )
        ]
        )
      );
  }
//个人信息中心
  Widget _info(){
    return Container(
     //height: ScreenUtil().setHeight(200),
    // width: ScreenUtil().setWidth(750),
     padding: EdgeInsets.only(top: 5.0,bottom: 0.0),
     child: Row(
       children: <Widget>[
        Expanded(
          child:  
          Column(
           children: <Widget>[
             Text('您的余额',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(22),
               color: Colors.white
             ),),
             Text(''),
             Text(''),
             Text('¥0.00',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(18),
               color: Colors.yellowAccent
             ),)
           ],
         ),
        ),
        Expanded(
          child:  Column(
           children: <Widget>[
             CircleAvatar(
              radius: 25.0,
              backgroundImage:AssetImage("assets/images/member/132.jpeg"),
             ),
             Text('',style: TextStyle(
              color: Colors.white,
               fontSize: ScreenUtil().setSp(10)
             ),),
             Text('我的名字',style: TextStyle(
              color: Colors.white)),
            Text(''),
             InkWell(
               onTap: (){
                 print('点击了退出按钮');
               },
               child: Text('退出登录',
               style: TextStyle(
              color: Colors.white,)
              ),
             )
           ],
         ), 
        ),
        Expanded(
          child:  Column(
           children: <Widget>[
             Text('您的积分',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(22),
               color: Colors.white
             ),),
             Text(''),
             Text(''),
             Text('¥0.00',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(18),
               color: Colors.yellowAccent
             ),)
           ],
         )
        )
       ],
     ),
    );
  }

  Widget _bottominfo(){
    return Container(
      padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
     // height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(750),
      color: Colors.blue,
      child: Row(
        children: <Widget>[
 Expanded(
          child:  Container(
           // padding: EdgeInsets.only(top: 2.0,bottom: 2.0),
            child:  Column(
           children: <Widget>[
             Text('我的通知',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(25),
               color: Colors.white
             ),),
             Text('1',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(20),
               color: Colors.yellowAccent
             ),)
           ],
         ),
         decoration: BoxDecoration(
           border: Border(
             right: BorderSide(
               width: 1,
               color: Colors.white
             )
           )
         ),
          )
         
         
        ),
         Expanded(
          child: Container(
           // padding: EdgeInsets.only(top: 2.0,bottom: 2.0),
            child:  Column(
           children: <Widget>[
             Text('我的收藏',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(25),
               color: Colors.white
             ),),
             Text('1',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(20),
               color: Colors.yellowAccent
             ),)
           ],
         ),
         decoration: BoxDecoration(
           border: Border(
             right: BorderSide(
               width: 1,
               color: Colors.white
             )
           )
         ),
          )
        )
        ,
         Expanded(
          child:  
          Column(
           children: <Widget>[
             Text('今天作业',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(25),
               color: Colors.white
             ),),
             Text('0',
             style: TextStyle(
               fontSize: ScreenUtil().setSp(20),
               color: Colors.yellowAccent
             ),)
           ],
         ),         
        )
        ],
      ),
    );
  }
}