import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

postSummary(int index, {required bool topBorderRadios}) {
  return Container(
    margin: EdgeInsets.only(top: 1.h, right: 12.w),
    width: 460.w,
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          height: 360.h,
          margin: EdgeInsets.only(left: 4.h),
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(topBorderRadios ? 20 : 0),
                topLeft: Radius.circular(topBorderRadios ? 20 : 0),
                bottomRight: const Radius.circular(20.0),
                bottomLeft: const Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/icons/sandClock.png'),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text("Due on".tr()),
                    const Text("2d, 3h, 26m"),
                  ],
                ),
              ),
              SizedBox(
                height: 250.h,
                child: Image.asset(
                  'assets/images/sample.png',
                  fit: BoxFit.contain,
                ),
              ),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Row(
                    children: [
                      Text("This is the content".tr()),
                    ],
                  )),
              // )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10.h, 20.w, 0),
          child: Row(
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/facebook.png',
                fit: BoxFit.fitHeight,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
