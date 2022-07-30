import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Data/classes/feelings.dart';
import '../../Data/classes/post.dart';
import '../../widgets/feeling_widget.dart';
import '../../widgets/get_image.dart';
import '../../widgets/save_dialog.dart';

class FaceCreate extends StatefulWidget {
  static const String screenName = "FaceCreate";
  static const int postType = 1;

  @override
  State<FaceCreate> createState() => _FaceCreateState();
}

class _FaceCreateState extends State<FaceCreate> {
  TextEditingController contentController = TextEditingController();
  String? selectedFeeling;

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4267B2),
        title: Text("NFPost".tr()),
        actions: [
          IconButton(
              onPressed: () {
                Post post = Post(
                    type: FaceCreate.postType,
                    content: contentController.text,
                    creationTime: DateTime.now(),
                    feeling: selectedFeeling,
                    image: selectedImage);

                showDialog(
                    context: context,
                    builder: (context) =>
                        showSaveAlert(post, selectedImage, context));
              },
              icon: Icon(
                Icons.done,
                size: 40.h,
              ))
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(12.h),
          height: screenHeight,
          child: ListView(
            children: [
              feelingWidget(selectedFeeling),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                child: TextField(
                  // controller: contentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "FCH".tr(),
                  ),
                ),
              ),
              Container(
                child: selectImage(selectedImage),
              ),
            ],
          )),
      bottomNavigationBar: SizedBox(
          height: 200.h,
          child: Column(
            children: [
              const Divider(),
              ListTile(
                onTap: () async {
                  selectedImage = await getImage(context);
                  setState(() {});
                },
                leading: Image.asset("assets/images/add_photo.png"),
                title: Text("Photo".tr()),
              ),
              const Divider(),
              DropdownButton<String>(
                  hint: ListTile(
                    title: Text("Feeling".tr()),
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset('assets/images/feeling.png'),
                    ),
                  ),
                  isExpanded: true,
                  underline: SizedBox(),
                  value: selectedFeeling,
                  items: (Feeling.toList()).map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: ListTile(
                        title: Text(e),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/emojis/$e.png'),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    selectedFeeling = v;
                    setState(() {});
                  }),
            ],
          )),
    );
  }
}
