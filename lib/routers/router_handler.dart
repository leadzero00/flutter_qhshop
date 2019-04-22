import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';

Handler detailsHanderl = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> pargms ){
    String detailsid = pargms['id'].first;
    print('$detailsid');
    return DetailsPage(detailsid);
  }
);