import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

feelingWidget(String? emojiName) {
  return Container(
    height: emojiName == null ? 0 : 50.h,
    child: emojiName == null || emojiName == ''
        ? const SizedBox()
        : ListTile(
            minLeadingWidth: 5,
            leading: Image.asset('assets/emojis/$emojiName.png'),
            title: Text("${"- Feeling".tr()} ${emojiName.tr()}"),
          ),
  );
}
