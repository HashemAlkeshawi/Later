import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../Data/classes/post.dart';
import 'AppRouter.dart';

imageSource(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
            child: Text("Camera"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
            child: const Text("gallery "),
          ),
        ],
      ),
    ),
  );
}

ifEmptyPosts(int count, int type) {
  Widget? widget;
  count != 0
      ? widget = Text('$count')
      : widget = InkWell(
          onTap: () {
            AppRouter.navigateToWidget(Post.widgetByTypeToCreate(type));
          },
          child: const Icon(Icons.add,
              color: Color.fromARGB(255, 0, 0, 0), size: 22),
        );

  return widget;
}

postSummaryImage(Post post) {
  Widget widget;
  post.image!.path != ''
      ? widget = Image.file(
          post.image!,
        )
      : widget = selectImageByType(post);
  return widget;
}

selectImageByType(Post post) {
  switch (post.type) {
    case 1:
      return Image.asset('assets/images/facebook.png');
    case 2:
      return Image.asset('assets/images/instagram.png');
    case 3:
      return post.isEdited ?? false
          ? Image.asset('assets/images/twitter_edited.png')
          : Image.asset('assets/images/twitter.png');
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
