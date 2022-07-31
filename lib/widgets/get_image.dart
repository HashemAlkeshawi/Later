import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

getImage(BuildContext context) async {
  bool isCamera = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text("Camera"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("gallery "),
          ),
        ],
      ),
    ),
  );

  XFile? file = await ImagePicker()
      .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);

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
  image == null
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
