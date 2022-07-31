import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/Data/postsProvider.dart';
import 'package:later/widgets/Widgets_Util.dart/values.dart';
import 'package:later/widgets/bottomNavBar.dart';
import 'package:later/widgets/postSummary.dart';
import 'package:provider/provider.dart';
import '../Data/classes/post.dart';
import '../widgets/Widgets_Util.dart/AppRouter.dart';
import '../widgets/Widgets_Util.dart/decision_widgets.dart';
import '../widgets/floatingActBtn.dart';

class Home extends StatefulWidget {
  static const String screenName = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(minutes: 1),
        (Timer t) => setState((() {
              print('hello');
            })));
  }

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
      floatingActionButton: floatingActBtn(),
      body: Container(
          margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: LaterColors.facebookColor,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
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
                          decoration: const BoxDecoration(
                            color: LaterColors.facebookSecondaryColor,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: ifEmptyPosts(
                                Provider.of<postsProvider>(context)
                                    .facebookPosts!
                                    .length,
                                1),
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
                          decoration: const BoxDecoration(
                            color: LaterColors.instagramColor,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
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
                          decoration: const BoxDecoration(
                            color: LaterColors.instagramSecondaryColor,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: ifEmptyPosts(
                                Provider.of<postsProvider>(context)
                                    .instagramPosts!
                                    .length,
                                2),
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
                          decoration: const BoxDecoration(
                            color: LaterColors.twitterColor,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
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
                          decoration: const BoxDecoration(
                            color: LaterColors.twitterSecondaryColor,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15)),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Center(
                            child: ifEmptyPosts(
                                Provider.of<postsProvider>(context)
                                    .twitterPosts!
                                    .length,
                                3),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // topRight: Radius.circular(20.0),
                    // topLeft: Radius.circular(20.0)),
                    color: LaterColors.mainColor),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.w,
                    ),
                    Text(
                      "DueSoonPosts".tr(),
                      style: TextStyle(
                          color: Colors.white, fontSize: FontSize.xxl.sp),
                    ),
                  ],
                ),
              ),
              Container(
                // color: Colors.red,
                margin: EdgeInsets.only(top: 8.h),
                height: 375.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Provider.of<postsProvider>(context)
                        .postsDueSoon!
                        .length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Post post = Provider.of<postsProvider>(context)
                          .postsDueSoon![index];
                      return InkWell(
                          onTap: () {
                            print(post.content ?? "nothing");
                            AppRouter.navigateToWidget(Post.WidgetByType(post));
                          },
                          child:
                              postSummary(post: post, topBorderRadios: false));
                    }),
              ),
            ],
          )),
      bottomNavigationBar: BottomNavBar(screenWidth, Home.screenName),
    );
  }
}
