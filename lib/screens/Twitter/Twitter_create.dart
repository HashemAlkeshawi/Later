import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/screens/Home.dart';
import 'package:later/widgets/Widgets_Util.dart/values.dart';

import '../../Data/classes/feelings.dart';
import '../../Data/classes/post.dart';
import '../../widgets/Widgets_Util.dart/AppRouter.dart';
import '../../widgets/feeling_widget.dart';
import '../../widgets/get_image.dart';
import '../../widgets/save_dialog.dart';

class TwitterCreate extends StatefulWidget {
  static const String screenName = "TwitterCreate";
  static const int postType = 3;

  @override
  State<TwitterCreate> createState() => _TwitterCreateState();
}

class _TwitterCreateState extends State<TwitterCreate> {
  TextEditingController contentController = TextEditingController();

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    ////////////
    FocusNode inputNode = FocusNode();
    void openKeyboard() {
      FocusScope.of(context).requestFocus(inputNode);
    }

////////////
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LaterColors.twitterColor,
        title: Text("NTPost".tr()),
      ),
      body: Container(
        padding: EdgeInsets.all(12.h),
        height: screenHeight,
        child: ListView(
          children: [
            TextField(
              keyboardType: TextInputType.values[0],
              focusNode: inputNode,
              controller: contentController,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "TCH".tr(),
              ),
            ),
            Container(
              child: selectImage(selectedImage),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          height: 100.h,
          child: Column(
            children: [
              const Divider(),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      selectedImage = await getImage(context);
                      setState(() {});
                    },
                    icon: Image.asset('assets/images/addImage.png'),
                  ),
                  IconButton(
                    onPressed: () {
                      openKeyboard();
                    },
                    icon: Image.asset('assets/images/smile.png'),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () async {
                        Post post = Post(
                            type: TwitterCreate.postType,
                            content: contentController.text,
                            creationTime: DateTime.now(),
                            image: selectedImage);

                        await showDialog(
                            context: context,
                            builder: (context) => showSaveAlert(post, context));
                        AppRouter.popFromWidget();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff00ACEE),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        height: 60.h,
                        width: 250.w,
                        child: Center(
                          child: Text(
                            "saveTweet".tr(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ))
                ],
              )
            ],
          )),
    );
  }
}
