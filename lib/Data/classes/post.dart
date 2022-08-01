import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:later/screens/Facebook/Facebook_Update.dart';
import 'package:later/screens/Facebook/Facebook_create.dart';
import 'package:later/screens/Facebook/Facebook_post.dart';
import 'package:later/screens/Instagram/Instagram_Update.dart';
import 'package:later/screens/Instagram/Instagram_create.dart';
import 'package:later/screens/Twitter/Twitter_Update.dart';
import 'package:later/screens/Twitter/Twitter_create.dart';
import 'package:path_provider/path_provider.dart';

import '../../screens/Instagram/Instagram_post.dart';
import '../../screens/Twitter/Twitter_post.dart';
import '../database/db_helper.dart';

class Post {
  int? id;
  String? content;
  DateTime? creationTime;
  DateTime? dueOn;
  File? image;
  bool isTimed = false;
  late int type;
  String? feeling;
  bool isEdited = false;

  Post(
      {this.isEdited = false,
      this.content,
      this.creationTime,
      this.feeling,
      this.image,
      this.dueOn,
      this.isTimed = false,
      required this.type});

  Post.fromMap(Map<String, dynamic> map) {
    id = map[PostsTable.idColumName];
    content = map[PostsTable.contentColumName];
    creationTime = DateTime.tryParse(map[PostsTable.creationTimeColumName]);
    dueOn = DateTime.tryParse(map[PostsTable.dueOnColumName]);
    image = File(map[PostsTable.imagePathColumName]);
    isTimed = map[PostsTable.isTimedColumName] == 1 ? true : false;
    isEdited = map[PostsTable.isEditedColumName] == 1 ? true : false;
    type = map[PostsTable.typeColumName];
    feeling = map[PostsTable.feelingColumName];
  }

  toMap() async {
    Map<String, dynamic> postInMap = {
      PostsTable.contentColumName: content,
      PostsTable.creationTimeColumName: creationTime.toString(),
      PostsTable.dueOnColumName: dueOn.toString(),
      PostsTable.imagePathColumName: await selectedmagePath(image),
      PostsTable.isTimedColumName: isTimed ? 1 : 0,
      PostsTable.isEditedColumName: isEdited ? 1 : 0,
      PostsTable.typeColumName: type,
      PostsTable.feelingColumName: feeling
    };
    return postInMap;
  }

  String dueToTime() {
    Duration duration = dueOn!.difference(DateTime.now());

    int days = duration.inDays;
    int hours = duration.inHours - (days * 24);
    int minutes = duration.inMinutes - ((days * 24 + hours) * 60);

    String sDays = '${days}d, ';
    String sHours = '${hours}h, ';
    String sMinutes = '${minutes}m';

    String remainingTime =
        '${days != 0 ? sDays : ''}${hours != 0 ? sHours : ''}${minutes != 0 ? sMinutes : ''}';

    return remainingTime;
  }

  sharingDate() {
    Widget widget;
    widget = isTimed
        ? Row(
            children: [
              Text("SharingDate".tr()),
              Text(DateFormat.jm().add_yMMMEd().format(dueOn!))
            ],
          )
        : const SizedBox();

    return widget;
  }

  Future<String> selectedmagePath(File? selectedImage) async {
    String? imagePath;
    final Directory path = await getApplicationDocumentsDirectory();
    String appPath = path.path;
    if (selectedImage == null) {
    } else if (selectedImage.path != '') {
      String imageFileType =
          selectedImage.path.substring(selectedImage.path.length - 4);
      final File imageFile =
          await selectedImage.copy('$appPath/${DateTime.now()}$imageFileType');

      imagePath = imageFile.path;
    }

    print(imagePath);

    return imagePath ?? '';
  }

  properContent() {
    String? properContent;
    content == null
        ? properContent = ''
        : content!.length > 25
            ? properContent = "${content!.substring(0, 24)}.."
            : properContent = content;

    return properContent;
  }

  static WidgetByType(Post post) {
    switch (post.type) {
      case 1:
        return FacePost(post);
      case 2:
        return InstaPost(post);
      case 3:
        return TwitterPost(post);
    }
  }

  static widgetByTypeToCreate(int type) {
    switch (type) {
      case 1:
        return FaceCreate();
      case 2:
        return InstaCreate();
      case 3:
        return TwitterCreate();
    }
  }

  static widgetByTypeToUpdate(Post post) {
    switch (post.type) {
      case 1:
        return FaceUpdate(post);
      case 2:
        return InstaUpdate(post);
      case 3:
        return TwitterUpdate(post);
    }
  }
}
