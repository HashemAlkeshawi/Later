import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Data/classes/feelings.dart';
import '../../Data/classes/post.dart';
import '../../widgets/feeling_widget.dart';
import '../../widgets/get_image.dart';
import '../../widgets/save_dialog.dart';

class FaceUpdate extends StatefulWidget {
  Post post;
  FaceUpdate(this.post);

  static const String screenName = "FaceUpdate";
  static const int postType = 1;

  @override
  State<FaceUpdate> createState() => _FaceUpdateState();
}

class _FaceUpdateState extends State<FaceUpdate> {
  TextEditingController contentController = TextEditingController();
  String? selectedFeeling;

  File? selectedImage;
  DateTime? dueOn;
  bool? isTimed;
  int? oldPostId;
  @override
  void initState() {
    oldPostId = widget.post.id;
    Post post = widget.post;
    contentController.text = post.content!;
    selectedFeeling = post.feeling;
    isTimed = post.isTimed;
    selectedImage = post.image;
    dueOn = post.dueOn;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4267B2),
        title: Text("UFPost".tr()),
        actions: [
          IconButton(
              onPressed: () async {
                Post post = Post(
                    type: FaceUpdate.postType,
                    content: contentController.text,
                    creationTime: DateTime.now(),
                    feeling: selectedFeeling,
                    dueOn: dueOn,
                    isTimed: isTimed!,
                    image: selectedImage,
                    isEdited: true);

                // post.isEdited = true;

                await showDialog(
                    context: context,
                    builder: (context) => showSaveAlert(
                        post, oldPostId!, context,
                        isSave: false));
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
                  controller: contentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "FCH".tr(),
                  ),
                ),
              ),
              Container(
                child: selectedImage!.path != ''
                    ? selectImage(selectedImage)
                    : const SizedBox(),
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
