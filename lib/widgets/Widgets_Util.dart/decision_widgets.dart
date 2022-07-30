import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Data/classes/post.dart';

postSummaryImage(File image, int type) {
  print('this is the image ${image.toString()}');
  Widget widget;
  image.path != ''
      ? widget = Image.file(image)
      : widget = selectImageByType(type);
  return widget;
}

selectImageByType(int type) {
  switch (type) {
    case 1:
      return Image.asset('assets/images/facebook.png');
    case 2:
      return Image.asset('assets/images/instagram.png');
    case 3:
      return Image.asset('assets/images/twitter.png');
  }
}

showIfTimed(Post post) {
  Widget widget;
  !post.isTimed
      ? widget = const SizedBox()
      : widget = Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/icons/sandClock.png'),
              SizedBox(
                width: 12.w,
              ),
              Text("Due on".tr()),
              Text(post.dueToTime()),
            ],
          ),
        );
  return widget;
}
