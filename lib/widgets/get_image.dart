import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

getImage(BuildContext context) async {
  bool? isCamera = await showDialog(
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
      .pickImage(source: isCamera! ? ImageSource.camera : ImageSource.gallery);
  return File(file!.path);
}

selectImage(File? image) {
  Widget? widget;
  image == null
      ? widget = const SizedBox()
      : widget = Image.file(
          image,
          fit: BoxFit.contain,
        );
  return widget;
}
