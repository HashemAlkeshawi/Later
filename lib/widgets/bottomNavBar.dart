import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/widgets/Widgets_Util.dart/AppRouter.dart';
import 'package:later/screens/Home.dart';
import 'package:later/widgets/Widgets_Util.dart/values.dart';

import '../screens/PostsScreen.dart';

BottomNavBar(double screenWidth, String screenName) {
  String? homeActivity = '_';
  String? postsActivity = '_';
  screenName == Home.screenName
      ? homeActivity = 'Active'
      : postsActivity = 'Active';
  return Container(
    color: Colors.transparent,
    height: 110.h,
    child: Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Container(
          padding: EdgeInsets.only(right: 50.w),
          height: 80.h,
          width: screenWidth,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, -0.3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: () => screenName == PostsScreen.screenName
                ? {}
                : AppRouter.navigateWithReplacemtnToWidget(PostsScreen()),
            child: Row(
              children: [
                Spacer(),

                Image.asset('assets/icons/Post$postsActivity.png'),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  "All Posts".tr(),
                  style: TextStyle(
                      color: screenName == PostsScreen.screenName
                          ? LaterColors.mainColor
                          : Colors.grey[700]),
                ),
                // )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => screenName == Home.screenName
              ? {}
              : AppRouter.navigateWithReplacemtnToWidget(Home()),
          child: Container(
            height: 110,
            margin: EdgeInsets.fromLTRB(65.w, 0, 0, 6.h),
            child: Image.asset(
              'assets/icons/home$homeActivity.png',
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    ),
  );
}
