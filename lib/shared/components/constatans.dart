import 'package:flutter/material.dart';
import 'package:social_app/modules/login_screen/login_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';

const default_color=Colors.blue;

void SignOut(context){
  CacheHelper.removeData(key: 'token').then((value) => {
    if(value==true) navigateToAndFinish(context,LoginScreen())
  });
}

void printFullText(dynamic text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String uId = '';