import '../config/service_url.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

Future requst(var url, {formData}) async {
  try {
    print("开始读取数据");
    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    if (formData != null) {
      response = await dio.post(serverAdress[url], data: formData);
    } else {
      response = await dio.post(serverAdress[url]);
    }
    if (response.hashCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常,请检测代码和服务器情况.........');
    }
  } catch (e) {
    print('ERROR:======>${e}');
  }
}

Future getrequst(var url) async {
  try {
    print("开始读取数据");
    Response response;
    Dio dio = Dio();
   // dio.options.contentType =
       // ContentType.parse('application/x-www-form-urlencoded');
      response = await dio.get(serverAdress[url]);
      return response;
  } catch (e) {
    print('ERROR:======>${e}');
  }
}

Future getrequstdata(var url) async {
  try {
    print("开始读取数据");
    Response response;
    Dio dio = Dio();
   // dio.options.contentType =
       // ContentType.parse('application/x-www-form-urlencoded');
      response = await dio.get(serverAdress[url]);
      return response.data;
  } catch (e) {
    print('ERROR:======>${e}');
  }
}
