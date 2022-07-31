import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Data/classes/post.dart';
import 'AppRouter.dart';

ifEmptyPosts(int count, int type) {
  Widget? widget;
  count != 0
      ? widget = Text('$count')
      : widget = InkWell(
          onTap: () {
            AppRouter.navigateToWidget(Post.WidgetByTypeToCreate(type));
          },
          child: const Icon(Icons.add,
              color: Color.fromARGB(255, 0, 0, 0), size: 22),
        );

  return widget;
}

postSummaryImage(File image, int type) {
  print('this is the image ${image.toString()}');
  Widget widget;
  image.path != ''
      ? widget = Image.file(
          image,
        )
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
