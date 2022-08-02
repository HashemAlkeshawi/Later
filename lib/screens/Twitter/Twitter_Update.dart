import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/widgets/Widgets_Util.dart/values.dart';
import '../../Data/classes/post.dart';
import '../../widgets/Widgets_Util.dart/AppRouter.dart';
import '../../widgets/get_image.dart';
import '../../widgets/save_dialog.dart';

class TwitterUpdate extends StatefulWidget {
  Post post;
  TwitterUpdate(this.post);

  static const String screenName = "TwitterUpdate";
  static const int postType = 3;

  @override
  State<TwitterUpdate> createState() => _TwitterUpdateState();
}

class _TwitterUpdateState extends State<TwitterUpdate> {
  TextEditingController contentController = TextEditingController();

  File? selectedImage;
  bool? isTimed;
  DateTime? dueOn;
  int? oldPostId;
  void initState() {
    oldPostId = widget.post.id;
    Post post = widget.post;
    contentController.text = post.content!;
    isTimed = post.isTimed;
    dueOn = post.dueOn;
    selectedImage = post.image;
  }

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
              maxLength: 280,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "TCH".tr(),
              ),
            ),
            Container(
              child: selectedImage!.path != ''
                  ? selectImage(selectedImage)
                  : const SizedBox(),
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
                            type: TwitterUpdate.postType,
                            content: contentController.text,
                            isEdited: true,
                            isTimed: isTimed!,
                            dueOn: dueOn,
                            creationTime: DateTime.now(),
                            image: selectedImage);

                        await showDialog(
                            context: context,
                            builder: (context) => showSaveAlert(
                                post, oldPostId!, context,
                                isSave: false));
                        // AppRouter.popFromWidget();
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
