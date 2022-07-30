import 'dart:io';

import 'package:path_provider/path_provider.dart';

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

  Post(
      {this.content,
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
    type = map[PostsTable.typeColumName];
    feeling = map[PostsTable.feelingColumName];
  }

  toMap() {
    Map<String, dynamic> postInMap = {
      PostsTable.contentColumName: content,
      PostsTable.creationTimeColumName: creationTime.toString(),
      PostsTable.dueOnColumName: dueOn.toString(),
      PostsTable.imagePathColumName: selectedmagePath(image),
      PostsTable.isTimedColumName: isTimed ? 1 : 0,
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

    String stellInDateTime = '${days}d, ${hours}h, ${minutes}m';

    return stellInDateTime;
  }

  Future<String> selectedmagePath(File? selectedImage) async {
    String? imagePath;
    final Directory path = await getApplicationDocumentsDirectory();
    String appPath = path.path;
    if (selectedImage != null) {
      String imageFileType =
          selectedImage.path.substring(selectedImage.path.length - 4);

      final File imageFile =
          await selectedImage.copy('$appPath/${DateTime.now()}$imageFileType');

      imagePath = imageFile.path;
    }

    print(imagePath);

    return imagePath ?? '';
  }

  String typeImage() {
    switch (type) {
      case 1:
        return 'assets/images/facebook.png';
      case 2:
        return 'assets/images/instagram.png';
      case 3:
        return 'assets/images/twitter.png';
    }
    return '';
  }
}
