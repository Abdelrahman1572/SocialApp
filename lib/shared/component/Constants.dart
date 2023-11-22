import 'package:flutter/material.dart';
import 'package:socialapp/modules/login/login.dart';
import 'package:socialapp/shared/component/Components.dart';
import 'package:socialapp/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      NavigateAndFinish(context, const LoginScreen());
    }
  });
}

void printFullText(String? text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}

String token = '';
String CURRENT_UID = (CacheHelper.getData(key: 'uId') == null)
    ? ""
    : CacheHelper.getData(key: 'uId');

var defaultColor = Colors.blueGrey;
