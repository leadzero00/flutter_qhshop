import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../service/service_method.dart';

import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import '../../model/fenleikecheng.dart';
import '../../provide/cikakecheng.dart';
import '../../model/vidokechengmodel.dart';
import '../../provide/videokecheng.dart';

//路由
import '../../routers/application.dart';
import 'package:fluro/fluro.dart';

class Homepages extends StatefulWidget {
  @override
  _HomepagesState createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
      
  @override
  void initState() {
    getcikakechengrequst();
    _getvideorequst();
    _getvideorequst();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    //获取次卡课程信息
    return Container(
      color: Colors.black12,
      child: FutureBuilder(
        future: getrequst('titlepage'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            //swiper动画
            List<Map> swiper = (data['data']['swiper-wrapper'] as List).cast();
            //公告信息
            List<Map> noticeinfo = (data['data']['notice'] as List).cast();
            //gridview导航
            List<Map> navigatorList =
                (data['data']['ckcontainer'] as List).cast();
            if (navigatorList.length > 10) {
              navigatorList.removeRange(10, navigatorList.length);
            }
            //广告图
            List<Map> adbanner = (data['data']['adbanner'] as List).cast();
            //大分类名称
            List<Map> fenleitile =
                (data['data']['mianshikecheng'] as List).cast();
            return ListView(
              children: <Widget>[
                SwiperDiy(swiperDateList: swiper),
                NoticeInfo(noticeinfomation: noticeinfo),
                TopNavigater(navigater: navigatorList),
                Adbanner(adbanner: adbanner),
                FenleiTitle(fenleititle: fenleitile)
              ],
            );
          } else {
            return Text('正在加载数据中.....');
          }
        },
      ),
    );
  }

//获得次卡课程
  getcikakechengrequst() {
    getrequst('fenleikecheng').then((val) {
      var data = json.decode(val.toString());
      print(data);
      FenleiKechengModel fenleilist = FenleiKechengModel.fromJson(data);
      Provide.value<CiKaKechengProvide>(context)
          .getCiKakecheng(fenleilist.data);
    });
  }

  //获得视频信息
  _getvideorequst() {
    getrequst('videokecheng').then((val) {
      var data = json.decode(val.toString());
      print(data);
      VideoKechengModel videolist = VideoKechengModel.fromJson(data);
      Provide.value<VideoKechengProvide>(context)
          .changeVideoList(videolist.data);
    });
  }
}

/////////////////////////轮播图//////////////////////////
///////////////////////////////////////////////////////
class SwiperDiy extends StatelessWidget {
  final List<Map> swiperDateList;
  SwiperDiy({Key key, this.swiperDateList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: ScreenUtil().setHeight(350),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (context, index) {
          return Image.network('${swiperDateList[index]['image']}',fit: BoxFit.fill);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(), //设置 new SwiperPagination() 展示默认分页指示器
        autoplay: true,
        onTap: (index) {
          print('我按了第${index}个图标');
          return Fluttertoast.showToast(
              msg: "我按了" + swiperDateList[index]['title'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              fontSize: 16.0);
        },
      ),
    );
  }
}

//最新公告
class NoticeInfo extends StatelessWidget {
  final List noticeinfomation;
  NoticeInfo({Key key, this.noticeinfomation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.all(10.0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          Text('最新公告 Notice:  ',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(40), color: Colors.redAccent)),
          _textSwiper(context, noticeinfomation)
        ],
      ),
      //黑色底部线条
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black38))),
    );
  }

  Widget _textSwiper(BuildContext context, item) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 5),
      height: ScreenUtil().setHeight(40),
      width: ScreenUtil().setWidth(200),
      alignment: Alignment.centerLeft,
      child: Swiper(
        scrollDirection: Axis.vertical, //垂直滚动
        itemBuilder: (context, index) {
          return Text(
            '${item[index]['title']}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        },
        itemCount: item.length,
        pagination: null,
        autoplay: true,
        onTap: (index1) {
          print('我按了第${index1}个文字');
          Appliaction.router.navigateTo(context, "/detail?id=SB961092");
          return Fluttertoast.showToast(
              msg: "我准备进入" + item[index1]['title'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              fontSize: 16.0);
        },
      ),
    );
  }
}

//navigater
class TopNavigater extends StatelessWidget {
  final List navigater;
  TopNavigater({Key key, this.navigater}) : super(key: key);

  Widget _gridviewItemUi(BuildContext context, item) {
    return InkWell(
      onTap: () {
        Appliaction.router.navigateTo(context, "/detail?id=${item['title']}");
        // return Fluttertoast.showToast(
        //     msg: "我准备进入" + item['title'],
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIos: 1,
        //     backgroundColor: Colors.pink,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      },
      child: Column(
        children: <Widget>[
          Image.network(
            '${item['image']}',
            width: ScreenUtil().setWidth(95),
            height: ScreenUtil().setHeight(95),
          ),
          Text(item['title'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(340),
      color: Colors.white,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        padding: EdgeInsets.all(5.0),
        children: navigater.map((item) {
          return _gridviewItemUi(context, item);
        }).toList(),
      ),
    );
  }
}

//广告条
class Adbanner extends StatelessWidget {
  final List adbanner;
  Adbanner({Key key, this.adbanner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(top: 5.0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(370),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
              // padding: EdgeInsets.zero,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 0.0),
              width: ScreenUtil().setWidth(260),
              height: ScreenUtil().setHeight(320),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Appliaction.router.navigateTo(context, "/detail?id=${adbanner[0]['title']}");
                  // return Fluttertoast.showToast(
                  //     msg: "我准备进入" + adbanner[0]['title'],
                  //     toastLength: Toast.LENGTH_SHORT,
                  //     gravity: ToastGravity.CENTER,
                  //     timeInSecForIos: 1,
                  //     backgroundColor: Colors.pink,
                  //     textColor: Colors.white,
                  //     fontSize: 16.0);
                },
                child:
                    Image.network('${adbanner[0]['image']}', fit: BoxFit.fill),
              )),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5),
                  width: ScreenUtil().setWidth(450),
                  height: ScreenUtil().setHeight(160),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      return Fluttertoast.showToast(
                          msg: "我准备进入" + adbanner[1]['title'],
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.pink,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: Image.network('${adbanner[1]['image']}',
                        fit: BoxFit.fill),
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 5, 0.0, 0.0),
                width: ScreenUtil().setWidth(450),
                height: ScreenUtil().setHeight(160),
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    return Fluttertoast.showToast(
                        msg: "我准备进入" + adbanner[2]['title'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.pink,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: Image.network('${adbanner[2]['image']}',
                      fit: BoxFit.fill),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class FenleiTitle extends StatelessWidget {
  final List fenleititle;
  FenleiTitle({Key key, this.fenleititle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    try {
      return Container(
          padding: EdgeInsets.only(left: 5.0, right: 2.0),
          margin: EdgeInsets.only(top: 5.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _training(fenleititle, 0),
              _training(fenleititle, 1),
              CikaKecheng(),
              _training(fenleititle, 2),
              VideoKeChengInfoNavigater(),
              _training(fenleititle, 3),
              _training(fenleititle, 4),
            ],
          ));
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _training(item, index) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              // margin: EdgeInsets.fromLTRB(left, top, right, bottom),
              height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(540),
              child: Row(
                children: <Widget>[
                  Image.network(
                    '${item[index]['image']}',
                    height: 25,
                    width: 25,
                    fit: BoxFit.fill,
                  ),
                  Text('  ${item[index]['title']}',
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
            Container(
              padding: EdgeInsets.only(left: 40.0),
              height: ScreenUtil().setHeight(80),
              width: ScreenUtil().setWidth(190),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  print('点击了${item[index]['title']}');
                },
                child: Row(
                  children: <Widget>[
                    Text('更多>>', style: TextStyle(color: Colors.black45)),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black45))),
            ),
          ],
        )
      ],
    );
  }
}

////////////////////次卡课程信息开始//////////////////
///////////////////////////////////////////////
class CikaKecheng extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<CiKaKechengProvide>(
      builder: (context, child, cikakechenglist) {
        return Container(
            height: 195.00 *
                (Provide.value<CiKaKechengProvide>(context)
                    .cikakechenginfo
                    .length) /
                2,
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.only(left: 2.0, right: 2.0),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: cikakechenglist.cikakechenginfo.length,
              itemBuilder: (context, index) {
                //  print('长度啊啊啊啊 啊====>>>>>${cikakechenglist.cikakechenginfo.length}');
                if (cikakechenglist.cikakechenginfo.length == null ||
                    cikakechenglist.cikakechenginfo.length <= 0) {
                  return Text('正在获取数据...');
                } else {
                  return _fenleixinxi(cikakechenglist, index);
                }
              },
            ));
      },
    );
  }

  Widget _fenleixinxi(cikakechenglist, index) {
    return InkWell(
        onTap: () {
          return Fluttertoast.showToast(
              msg: "我准备进入" + cikakechenglist.cikakechenginfo[index].title,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black45))),
          child: Row(
            children: <Widget>[
              _leftImage(cikakechenglist, index),
              Column(
                children: <Widget>[
                  _rightTile(cikakechenglist, index),
                  _rightInfomation(cikakechenglist, index)
                ],
              )
            ],
          ),
        ));
  }

  Widget _leftImage(cikakechenglist, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network('${cikakechenglist.cikakechenginfo[index].image}',
          fit: BoxFit.fill),
    );
  }

  //右侧标题字符
  Widget _rightTile(cikakechenglist, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(504),
      child: Text(
        cikakechenglist.cikakechenginfo[index].title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(25), color: Colors.pinkAccent),
      ),
    );
  }

  //右侧相信信息
  Widget _rightInfomation(cikakechenglist, index) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, left: 5.0),
      width: ScreenUtil().setWidth(504),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('授课老师: ${cikakechenglist.cikakechenginfo[index].teacher}',
              style: TextStyle(fontSize: ScreenUtil().setSp(20))),
          Text('开课地点: ${cikakechenglist.cikakechenginfo[index].classaddress}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: ScreenUtil().setSp(20))),
          Text(
            '¥ ${cikakechenglist.cikakechenginfo[index].price}元',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(25), color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
////////////////////次卡课程信息结束//////////////////
///////////////////////////////////////////////////

///////////////////////////////////////////////////
////////////////////视频课程信息结束//////////////////
///////////////////////////////////////////////////
class VideoKeChengInfoNavigater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<VideoKechengProvide>(
      builder: (context, child, videodata) {
        return Container(
          color: Colors.black12,
          padding: EdgeInsets.all(5.0),
          height: videodata.videolist.length/2==1?175.00:175.00*videodata.videolist.length/1.4,
          child: GridView.count(
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
           // mainAxisSpacing: 2.0,
            crossAxisSpacing: 5.0,
            children: videodata.videolist.map((item) {
              return _videogridView(item);
            }).toList(),
          ),
        );
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
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment(0.0, 1.0),//层叠文字显示位置
            children: <Widget>[
              Image.network(datalist.image,
                  width: ScreenUtil().setWidth(350),height: ScreenUtil().setHeight(210), fit: BoxFit.fill),
              Container(
                decoration: BoxDecoration(color: Colors.black26),
                width: ScreenUtil().setWidth(350),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(200),
                padding: EdgeInsets.only(left: 2.0),
                color: Colors.white,
                child: Text(datalist.price,style: TextStyle(
                  color: Colors.redAccent,fontSize: 20.0
                ),),
              ),
              Container(
                width: ScreenUtil().setWidth(145),
               color: Colors.white,
                padding: EdgeInsets.only(left:15.0,top:7.5,bottom: 7.5,right: 2.0),
                child: 
                    Text('${datalist.howmany}人已学习',style: TextStyle(
                  fontSize: 10.0
                ),)
                  
              )
            ],
          )
        ],
      ),
    );
  }
}
