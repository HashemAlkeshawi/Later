import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/Data/postsProvider.dart';
import 'package:later/widgets/Widgets_Util.dart/values.dart';
import 'package:later/widgets/bottomNavBar.dart';
import 'package:later/widgets/postSummary.dart';
import 'package:provider/provider.dart';
import '../Data/classes/post.dart';
import '../widgets/floatingActBtn.dart';

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
      floatingActionButton: floatingActBtn(),
      body: Container(
          margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 18.h),
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
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          color: LaterColors.facebookSecondaryColor,
                          child: Center(
                            child: Text(
                                '${Provider.of<postsProvider>(context).facebookPosts!.length}'),
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
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          color: LaterColors.instagramSecondaryColor,
                          child: Center(
                            child: Text(
                                '${Provider.of<postsProvider>(context).instagramPosts!.length}'),
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
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          color: LaterColors.twitterSecondaryColor,
                          child: Center(
                            child: Text(
                                '${Provider.of<postsProvider>(context).twitterPosts!.length}'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
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
                      return postSummary(post: post, topBorderRadios: false);
                    }),
              ),
            ],
          )),
      bottomNavigationBar: BottomNavBar(screenWidth, screenName),
    );
  }
}
