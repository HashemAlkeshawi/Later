import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'Widgets_Util.dart/decision_widgets.dart';

getImage(BuildContext context) async {
  XFile? file =
      await ImagePicker().pickImage(source: await imageSource(context));

  return File(file!.path);
}

selectImage(File? image) {
  Widget? widget;
  image == null
      ? widget = const SizedBox()
      : widget = Image.file(
          image,
        );
  return widget;
}

instagramSelectImage(File? image) {
  Widget? widget;
  image == null || image.path == ''
      ? widget = Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          margin: EdgeInsets.all(12.r),
          height: 400.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "PaI".tr(),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 40.r,
                ),
              ],
            ),
          ),
        )
      : widget = Image.file(
          image,
          fit: BoxFit.contain,
        );
  return widget;
}
