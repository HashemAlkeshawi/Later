import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Data/classes/feelings.dart';
import '../../Data/classes/post.dart';
import '../../widgets/Widgets_Util.dart/AppRouter.dart';
import '../../widgets/feeling_widget.dart';
import '../../widgets/get_image.dart';
import '../../widgets/save_dialog.dart';
import '../Home.dart';

class InstaCreate extends StatefulWidget {
  static const String screenName = "InstaCreate";
  static const int postType = 2;

  @override
  State<InstaCreate> createState() => _InstaCreateState();
}

class _InstaCreateState extends State<InstaCreate> {
  TextEditingController contentController = TextEditingController();

  File? selectedImage;

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
                    type: InstaCreate.postType,
                    content: contentController.text,
                    creationTime: DateTime.now(),
                    image: selectedImage);

                await showDialog(
                    context: context,
                    builder: (context) => showSaveAlert(post, context));

                AppRouter.popFromWidget();
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
