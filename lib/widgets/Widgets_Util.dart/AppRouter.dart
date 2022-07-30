import 'package:flutter/material.dart';
import 'package:later/screens/Facebook/Facebook_create.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static Future<String?> navigateToWidget(Widget widget) async {
    String? x = await Navigator.of(navKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
    return x;
  }

  // staticnavigateToWidgetFromType(int type, post) async {
  //   Navigator.of(navKey.currentContext!)
  //       .push(MaterialPageRoute(builder: (context) {
  //         switch(type){
  //           case 1: return  FacePost(post);
  //           case 2:return  InstaPost(post);
  //           case 3:return  TwitterTweet(post);
  //         }
  //    return  FaceCreate();
  //   }));
  // }

  static navigateWithReplacemtnToWidget(Widget widget) {
    Navigator.of(navKey.currentContext!)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  static popFromWidget() {
    Navigator.of(navKey.currentContext!).pop();
  }
}
