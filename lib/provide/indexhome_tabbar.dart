import 'package:flutter/material.dart';

class IndexHomeTabbarProvide with ChangeNotifier{
List<Map> listbar = [];

 int currentIndex = 0; //切换页面编号
 var currentPage; //当前显示页面

 getIndexHomeTabar(List<Map> list){
   listbar = list;
 //  print('查询我目前的长度==>${listbar.length}');
  notifyListeners();
 }

 //设置页面编号

  setCurrentIndex(int currentindex){
    currentIndex = currentindex;
  }

  setCurrentPage(var currentpage)
  {
    currentPage = currentpage;
  }
 
}