import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:later/Data/database/db_helper.dart';
import 'package:later/Data/postsProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../Data/classes/post.dart';
import '../screens/Home.dart';
import 'Widgets_Util.dart/AppRouter.dart';

showSaveAlert(Post post, BuildContext context) {
  return AlertDialog(
    title: Text("alertSave".tr()),
    actions: [
      TextButton(
          onPressed: () {
            AppRouter.popFromWidget();
          },
          child: const Text("Cancel")),
      TextButton(
        onPressed: () async {
          await savePost(post, context, false);
          AppRouter.popFromWidget();
        },
        child: const Text("Skip & Save"),
      ),
      TextButton(
        onPressed: () async {
          await setDateTime(context, post);
          AppRouter.popFromWidget();
        },
        child: const Text("Set"),
      ),
    ],
  );
}

savePost(Post post, BuildContext context, bool fromDate) async {
  Provider.of<postsProvider>(context, listen: false).addNewPost(post);
}

setDateTime(BuildContext context, Post post) async {
  await DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2023, 12, 31),
      onChanged: (v) {}, onConfirm: (date) {
    post.dueOn = date;
    post.isTimed = true;
    print('confirm $date');
  }, currentTime: DateTime.now(), locale: LocaleType.en);
  savePost(post, context, true);
}
