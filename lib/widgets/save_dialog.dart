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

showSaveAlert(Post post, int oldPostId, BuildContext context,
    {required isSave}) {
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
          await savePost(post, oldPostId, context, false, isSave: isSave);
          AppRouter.popFromWidget();
          AppRouter.popFromWidget();
        },
        child: const Text("Skip & Save"),
      ),
      TextButton(
        onPressed: () async {
          await setDateTime(context, post, oldPostId, isSave: isSave);
          AppRouter.popFromWidget();
          AppRouter.popFromWidget();
        },
        child: const Text("Set"),
      ),
    ],
  );
}

savePost(Post post, int oldPostId, BuildContext context, bool fromDate,
    {required bool isSave}) async {
  isSave
      ? Provider.of<postsProvider>(context, listen: false).addNewPost(post)
      : Provider.of<postsProvider>(context, listen: false)
          .updateOnePost(post: post, oldPostId: oldPostId);
}

setDateTime(BuildContext context, Post post, int oldPostId,
    {required bool isSave}) async {
  await DatePicker.showDateTimePicker(context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2023, 12, 31),
      onChanged: (v) {}, onConfirm: (date) {
    post.dueOn = date;
    post.isTimed = true;
    print('confirm $date');
  }, currentTime: DateTime.now(), locale: LocaleType.en);
  savePost(post, oldPostId, context, true, isSave: isSave);
}
