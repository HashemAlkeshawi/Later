import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:later/widgets/bottomNavBar.dart';
import 'package:later/widgets/postSummary.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import '../widgets/floatingActBtn.dart';

class PostsScreen extends StatelessWidget {
  static const String screenName = "PostsScreen";

// temporary ...................
  List<String> catigories = [
    ('All'),
    ('facebook'),
    ('instagram'),
    ('twitter'),
  ];
///////.............
  @override
  Widget build(BuildContext context) {
    double screnHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        // floatingActionButton: floatingActBtn(),
        appBar: AppBar(
          backgroundColor: const Color(0xff1F97CF),
          title: Text(
            "Posts".tr(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              // padding: EdgeInsets.all(8.r),
              height: screnHeight - 110.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                    // child: DropdownButton<Catigory>(
                    child: DropdownButton<Object>(
                        hint: ListTile(
                          // title: Text(catigories.first.catigoryName!),
                          title: Text("This is the catigory name"),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.asset(
                                // 'assets/images/${catigories.first.catigoryName}.png'),
                                'assets/images/facebook.png'),
                          ),
                        ),
                        isExpanded: true,
                        underline: const SizedBox(),
                        // value: selectedCatigory,
                        items: catigories.map((e) {
                          return DropdownMenuItem<Object>(
                            value: e,
                            child: ListTile(
                              title: Text(e),
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Image.asset('assets/images/${e}.png'),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (v) {
                          // selectedCatigory = v;
                          // posts = categorize(listOfPosts_, posts!, selectedCatigory!);

                          // setState(() {});
                        }),
                  ),
                  SizedBox(
                    height: screnHeight - 220.h,
                    child: ListView.builder(
                      // controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        // dynamic post = posts![index];
                        return InkWell(
                            onTap: () {
                              // AppRouter.NavigateToWidget(selectType(post));
                              // AppRouter.NavigateToWidget(selectType(post));
                            },
                            child: SwipeableTile.swipeToTrigger(
                              color: Colors.white,
                              swipeThreshold: 0.5,
                              direction: SwipeDirection.horizontal,
                              // direction: SwipeDirection.endToStart,
                              onSwiped: (direction) {
                                if (direction == SwipeDirection.endToStart) {
                                  print('delete');
                                } else {
                                  print('edit');
                                }
                              },
                              backgroundBuilder:
                                  (context, direction, progress) {
                                if (direction == SwipeDirection.endToStart) {
                                  return Container(
                                    padding: EdgeInsets.only(left: 260.w),
                                    height: screnHeight - 210.h,
                                    color: Colors.red,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 80.r,
                                    ),
                                  );
                                } else if (direction ==
                                    SwipeDirection.startToEnd) {
                                  return Container(
                                    padding: EdgeInsets.only(right: 260.w),
                                    height: screnHeight - 210.h,
                                    color: Colors.greenAccent,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 80.r,
                                    ),
                                  );
                                }

                                return Container();
                              },
                              key: UniqueKey(),
                              child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 20.h, left: 15.w, right: 15.w),
                                  width: screenWidth,
                                  child: postSummary(index,
                                      topBorderRadios: true)),
                            ));
                      },
                      // itemCount: posts!.length,
                      itemCount: 5,
                    ),
                  ),
                ],
              ),
            ),
            BottomNavBar(screenWidth, screenName),
          ],
        ));
    // bottomNavigationBar: BottomNavBar(screenWidth, screenName));
  }
}
