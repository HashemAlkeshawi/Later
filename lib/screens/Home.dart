import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:later/widgets/Widgets_Util.dart/colors.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  static const String screenName = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: laterColors.mainColor,
        title: Text(
          "Home".tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Lottie.asset('assets/animation/welcom.json', repeat: false),
        ],
      )),
    );
  }
}
