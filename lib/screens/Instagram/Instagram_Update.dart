import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Data/classes/post.dart';
import '../../widgets/get_image.dart';
import '../../widgets/save_dialog.dart';

class InstaUpdate extends StatefulWidget {
  Post post;
  InstaUpdate(this.post);
  static const String screenName = "InstaUpdate";
  static const int postType = 2;

  @override
  State<InstaUpdate> createState() => _InstaUpdateState();
}

class _InstaUpdateState extends State<InstaUpdate> {
  TextEditingController contentController = TextEditingController();

  File? selectedImage;
  int? oldPostId;

  void initState() {
    oldPostId = widget.post.id;
    Post post = widget.post;
    contentController.text = post.content!;
    selectedImage = post.image;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "NIPost".tr(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Post post = Post(
                    type: InstaUpdate.postType,
                    content: contentController.text,
                    isEdited: true,
                    creationTime: DateTime.now(),
                    image: selectedImage);

                await showDialog(
                    context: context,
                    builder: (context) => showSaveAlert(
                        post, oldPostId!, context,
                        isSave: false));
              },
              icon: Icon(
                Icons.done,
                color: Colors.black,
                size: 40.h,
              ))
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(12.h),
          height: screenHeight,
          child: ListView(
            children: [
              InkWell(
                onTap: () async {
                  selectedImage = await getImage(context);
                  setState(() {});
                },
                child: instagramSelectImage(selectedImage),
              ),
              Container(
                height: 200.h,
                margin: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: TextField(
                  controller: contentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "ICH".tr(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
