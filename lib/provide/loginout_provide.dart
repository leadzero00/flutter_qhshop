import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginOrOutProvide with ChangeNotifier {
  var loginkey;
  var loginTime;

  getloginkey() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    loginkey = sp.getInt('loginkey');
    notifyListeners();
    return loginkey;
  }

  setloginKey() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    loginkey = sp.setInt('loginkey', 1);
    loginTime = sp.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
    notifyListeners();
    //  return loginkey;
  }

  setWXloginKey() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loginkey = sp.setInt('loginkey', 2);
    loginTime = sp.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
    notifyListeners();
    //  return loginkey;
  }

  setAlipayloginKey() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loginkey = sp.setInt('loginkey', 3);
    loginTime = sp.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
    notifyListeners();
    //  return loginkey;
  }

  setQQloginKey() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loginkey = sp.setInt('loginkey', 4);
    loginTime = sp.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
    notifyListeners();
    //  return loginkey;
  }

  setWeibologinKey() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loginTime = sp.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
    loginkey = sp.setInt('loginkey', 5);
    notifyListeners();
    //  return loginkey;
  }

  setQianhuiloginKey() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    loginTime = sp.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);
    loginkey = sp.setInt('loginkey', 6);
    notifyListeners();
    //  return loginkey;
  }
}
