import 'package:flutter/material.dart';

class IndexHomeTabbarProvide with ChangeNotifier{
List<Map> listbar = [];

 getIndexHomeTabar(List<Map> list){
   listbar = list;
 //  print('查询我目前的长度==>${listbar.length}');
  notifyListeners();
 }
 
}