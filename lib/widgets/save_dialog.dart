import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:later/Data/database/db_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../Data/classes/post.dart';
import 'Widgets_Util.dart/AppRouter.dart';

showSaveAlert(Post post, File? selectedImage, BuildContext context) {
  return AlertDialog(
    title: Text("alertSave".tr()),
    actions: [
      TextButton(
          onPressed: () {
            AppRouter.popFromWidget();
          },
          child: const Text("Cancel")),
      TextButton(
        onPressed: () => savePost(post, context),
        child: const Text("Skip & Save"),
      ),
      TextButton(
        onPressed: () => setDateTime(context, post, selectedImage),
        child: const Text("Set"),
      ),
    ],
  );
}

savePost(Post post, BuildContext context) async {
  Provider.of<DbHelper>(context, listen: false).insertNewPost(post);

  Navigator.pop(context);
  Navigator.pop(context);
}

void setDateTime(BuildContext context, Post post, File? selectedImage) {
  DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2023, 12, 31),
      onChanged: (v) {}, onConfirm: (date) {
    post.dueOn = date;
    post.isTimed = true;
    savePost(post, context);
    Navigator.pop(context);
    Navigator.pop(context);
    print('confirm $date');
  }, currentTime: DateTime.now(), locale: LocaleType.en);
}
