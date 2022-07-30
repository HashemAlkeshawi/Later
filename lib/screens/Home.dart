import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/widgets/Widgets_Util.dart/values.dart';
import 'package:later/widgets/bottomNavBar.dart';
import 'package:later/widgets/postSummary.dart';

class Home extends StatelessWidget {
  static const String screenName = "Home";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LaterColors.mainColor,
        title: Text(
          "Home".tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 22.h),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0)),
                    color: LaterColors.mainColor),
                child: Center(
                    child: Text(
                  "Posts".tr(),
                  style:
                      TextStyle(color: Colors.white, fontSize: FontSize.xxl.sp),
                )),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          color: LaterColors.facebookColor,
                          child: Center(
                            child: Text(
                              "Facebook".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.xl.sp),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          color: LaterColors.facebookSecondaryColor,
                          child: const Center(
                            child: Text("3"),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          color: LaterColors.instagramColor,
                          child: Center(
                            child: Text(
                              "Instagram".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.xl.sp),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          color: LaterColors.instagramSecondaryColor,
                          child: const Center(
                            child: Text("5"),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          color: LaterColors.twitterColor,
                          child: Center(
                            child: Text(
                              "Twitter".tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.xl.sp),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          color: LaterColors.twitterSecondaryColor,
                          child: const Center(
                            child: Text("2"),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 355.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        postSummary(1, topBorderRadios: false)),
              ),
            ],
          )),
      bottomNavigationBar: BottomNavBar(screenWidth, screenName),
    );
  }
}
