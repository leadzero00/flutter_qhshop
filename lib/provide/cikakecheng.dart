import 'package:flutter/material.dart';

class CiKaKechengProvide with ChangeNotifier{
List cikakechenginfo = [];

 getCiKakecheng(List list){
   cikakechenginfo = list;
   //print('我的数据啊啊啊啊啊啊啊:---======>>>>${cikakechenginfo}');
 //  print('查询我目前的长度==>${listbar.length}');
  notifyListeners();
 }
 
}