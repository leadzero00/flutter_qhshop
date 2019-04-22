import 'package:flutter/material.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

class Routes{
  static String root = '/';
  static String detaispage = '/details';
  static voidconfigureRoutes(Router router){
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context,Map<String ,List<String>> pafgms){
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
      }
    );
    router.define(detaispage,handler:detailsHanderl);
  }
}