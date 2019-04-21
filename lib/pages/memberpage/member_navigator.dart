import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridViewNavigatorList extends StatelessWidget {

List _navigatorIconList = [
  { 
   'image':'assets/images/members_nav/icon-xy01.png',
   'title': '我的视频',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy02.png',
   'title': '我的课程',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy03.png',
   'title': '我的老师',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy04.png',
   'title': '我的提问',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy05.png',
   'title':  '次卡课程',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy06.png',
   'title': '在做习题',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy07.png',
   'title': '错题集',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy08.png',
   'title': '我的书签',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy09.png',
   'title': '我的视频', 
   'url':''
  }
  ,
  { 
   'image':'assets/images/members_nav/icon-xy10.png',
   'title': '每日签到', 
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy11.png',
   'title': '习题收藏',
   'url':''
  },
  { 
   'image':'assets/images/members_nav/icon-xy12.png',
   'title': '更多',
   'url':''
  }
  ];
  @override
  Widget build(BuildContext context) { 
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(400),
      padding: EdgeInsets.only(top:10.0),
      child: GridView.count(
        crossAxisCount: 6,
        padding: EdgeInsets.all(2.0),
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        children:_navigatorIconList.map((item){
          return _listbar(item);
        }).toList()       
      )
    );
  }
  
  
    
  Widget _listbar(item){
    return InkWell(
            onTap: (){},
            child: Column(
              children: <Widget>[
                Container(
                width: ScreenUtil().setWidth(60),
                height: ScreenUtil().setHeight(60),
                child: Image.asset(item['image']),
                ), 
            Text(item['title'])
              ],
            )
    );
  }
}