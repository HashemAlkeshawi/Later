import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/widgets/feeling_widget.dart';

import '../../Data/classes/post.dart';

class FacePost extends StatelessWidget {
  static const String screenName = "Face_Post";

  Post post;
  FacePost(this.post);

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
      floatingActionButton: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.r,
        backgroundImage: AssetImage(
          typeImage,
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff4267B2),
        title: Text("FP".tr()),
      ),
      body: Container(
          padding: EdgeInsets.all(12.h),
          height: screenHeight,
          child: ListView(
            children: [
              feelingWidget(feeling),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.h),
                padding: EdgeInsets.all(10.r),
                child: Text(content),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 18.h),
                child: image == null ? const SizedBox() : Image.file(image),
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
