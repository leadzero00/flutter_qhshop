import 'package:flutter/material.dart';
class VideoKechengProvide with ChangeNotifier{

  List videolist;//默认视频列表
  String seachItem;//选择搜索核心
  String textField;//输入框内容

  List searchlist;//默认视频列表

  changeVideoList(List list){
    videolist = list;
    notifyListeners();
  }
  

  getchangeritemname(String items){
    seachItem = items;
    print('当前选择的是哪项$seachItem');
    notifyListeners();
  }

  getTextfieldString(String text){
    textField = text;
    notifyListeners();

  }

  getTextfieldList(List list){
    print('获得视频课程模式的界面时候的list数值是::::$searchlist');
    if(searchlist==null&&videolist!=null){
     searchlist= videolist;
    }else{
    searchlist = list;
    }
    notifyListeners();

  }
  
}