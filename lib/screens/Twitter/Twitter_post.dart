import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/Data/postsProvider.dart';
import 'package:later/widgets/Widgets_Util.dart/AppRouter.dart';
import 'package:later/widgets/Widgets_Util.dart/values.dart';
import 'package:later/widgets/feeling_widget.dart';
import 'package:provider/provider.dart';

import '../../Data/classes/post.dart';
import '../../widgets/app_bar_actions.dart';

class TwitterPost extends StatelessWidget {
  static const String screenName = "Twitter_Post";

  Post post;
  TwitterPost(this.post);

  @override
  Widget build(BuildContext context) {
    String creationDate = DateFormat.yMMMMEEEEd().format(post.creationTime!);
    String? feeling = post.feeling;
    String content = post.content!;
    File? image = post.image;
    String typeImage = post.typeImage();
    DateTime? dueOn = post.dueOn;
    bool isTimed = post.isTimed;

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Image.asset(typeImage),
      appBar: AppBar(
        backgroundColor: LaterColors.twitterColor,
        title: Text("TP".tr()),
        actions: [appBarActions(post)],
      ),
      body: Container(
          padding: EdgeInsets.all(12.h),
          height: screenHeight,
          child: ListView(
            children: [
              content != ''
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 18.h),
                      padding: EdgeInsets.all(10.r),
                      child: Text(content),
                    )
                  : const SizedBox(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.h),
                child: image!.path == '' ? const SizedBox() : Image.file(image),
              ),
              const Divider(),
              Row(
                children: [Text("lastUpdate".tr()), Text(creationDate)],
              ),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.only(bottom: 150.h),
                child: post.sharingDate(),
              ),
            ],
          )),
    );
  }
}
