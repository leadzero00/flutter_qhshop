import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/videokecheng.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../service/service_method.dart';
import 'dart:convert';
import '../../model/vidokechengmodel.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  final List _choosefruits = [
    '请选择',
    '面授课程',
    '视频课程',
    // '次卡课程',
    // '在线考试',
    // '教师风采',
    // '学校新闻'
  ];
  List<DropdownMenuItem<String>> _dropdownItem;

  String _selectedFruit;

  @override
  void initState() {
    // TODO: implement initState
    _dropdownItem = buildAndGetDropDownMenuItems(_choosefruits);
    _selectedFruit  = _dropdownItem[0].value;
    super.initState();
  }

List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = List();
    for (String fruit in fruits) {
      items.add(DropdownMenuItem(value: fruit, child: Text(fruit)));
    }
    return items;
  }

void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedFruit = selectedFruit;
    });
    Provide.value<VideoKechengProvide>(context).getchangeritemname(_selectedFruit);//把选择数值放入数据中
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child:Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.greenAccent,
           title: Container(
             child: Row(
               children: <Widget>[
                 Container(
                   width: ScreenUtil().setWidth(175),
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                   margin:EdgeInsets.only(top: 5.0,bottom: 5.0),
                   color: Colors.white,
                   child: DropdownButton(
                     value: _selectedFruit,
                     items: _dropdownItem,
                     onChanged: changedDropDownItem,
                     style: TextStyle(
                       fontSize: 12.0,
                       color: Colors.black
                     ),
                   ),
                   
                 ),
                 Container(
                   padding: EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                   margin: EdgeInsets.only(left:5.0,top: 5.0,bottom: 5.0),
                   width: ScreenUtil().setWidth(490),
                   child: _setTextField(),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     border: Border(
                       top: BorderSide(
                         width: 1,
                         color: Colors.black12
                       ),
                        left: BorderSide(
                         width: 1,
                         color: Colors.black12
                       ),
                        right: BorderSide(
                         width: 1,
                         color: Colors.black12
                       ),
                        bottom: BorderSide(
                         width: 1,
                         color: Colors.black12
                       )
                     )
                   ),
                 )

               ],
             ),
           ),
         ),
         body: CanvasWindows(),
       )
      
    );
  }

//输入框样式
  Widget _setTextField(){
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.text_fields),
        helperText: '请输入您要搜索的关键词',
      ),
      onChanged: _textFieldChanged,
      autofocus: false,
    );
  }
  
  void _textFieldChanged(String s){
    Provide.value<VideoKechengProvide>(context).textField = s;
    print(s);
  //  return Provide.value<VideoKechengProvide>(context).textField;
  }
}


class CanvasWindows extends StatefulWidget {
  @override
  _CanvasWindowsState createState() => _CanvasWindowsState();
}

class _CanvasWindowsState extends State<CanvasWindows> {
  @override
  Widget build(BuildContext context) {
    return  Provide<VideoKechengProvide>(
      builder: (context,child,listdata)
      {
        if(listdata.searchlist!=null){        
        return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(2.0),
      child: Column(
        children: <Widget>[
          Container(
          height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(700),
              child: Row(
                children: <Widget>[
                  Text(' 视频教程',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: ScreenUtil().setSp(26))),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black45))),
            ),
          Wrap(
        spacing: 2,
        children: listdata.searchlist.map((item){
          return _videogridView(item);
        }).toList(),
      ),
        ],
      )
      
    );}else{
       getrequst('videokecheng').then((onValue){
            var data = json.decode(onValue.toString());
            VideoKechengModel videolist = VideoKechengModel.fromJson(data);
            Provide.value<VideoKechengProvide>(context)
          .getTextfieldList(videolist.data);
          });
      return Text('正在加载中....');
    }
      },
    );
    
  }

  Widget _videogridView(datalist) {
    return InkWell(
      onTap: () {
        return Fluttertoast.showToast(
              msg: "我准备进入" + datalist.title,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              fontSize: 16.0);
      },
      child:  Container(
        padding: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(bottom: 3.0),
        width: ScreenUtil().setWidth(350),
        child:  Column(
        children: <Widget>[
          Stack(
            alignment: Alignment(0.0, 1.0),//层叠文字显示位置
            children: <Widget>[
              Image.network(datalist.image,
                  width: ScreenUtil().setWidth(375),height: ScreenUtil().setHeight(210), fit: BoxFit.fill),
              Container(
                decoration: BoxDecoration(color: Colors.black26),
                width: ScreenUtil().setWidth(375),
                child: Text(
                  datalist.title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(datalist.price+"       ",style: TextStyle(
                  color: Colors.redAccent,fontSize: 20.0
                ),),
                    Text('${datalist.howmany}人已学习',style: TextStyle(
                  fontSize: 10.0
                ),)                 
            ],
          )
        ],
      ),
      )
    );
  }

}